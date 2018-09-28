<template>
	<div>
    <el-dialog title="新增" :visible.sync="dialogFlg" :close-on-click-modal="false"  :before-close="beforeClose">
  		<el-form ref="goodsForm" :rules="goodsRules" :model="goodsForm" label-width="100px" @submit.prevent="submitForm" style="margin:20px;width:60%;min-width:600px;">
        <el-form-item label="商品名称" prop="gName">
          <el-input v-model="goodsForm.gName"></el-input>
        </el-form-item>
        <el-form-item label="所属分类" prop="cId">
          <el-select v-model="goodsForm.cId" placeholder="请选择">
            <el-option
              v-for="item in cates"
              :key="item.cId"
              :label="item.cName"
              :value="item.cId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品封面图" prop="gLogo">
          <!-- <el-input v-model.number="goodsForm.gLogo"></el-input> -->
          <el-upload
            name="file"
            class="avatar-uploader"
            action="/api/file/testuploadimg"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <img v-if="goodsForm.gLogo" :src="goodsForm.gLogo" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="促销价" prop="gPrice">
          <el-input type="number" v-model="goodsForm.gPrice"></el-input>
        </el-form-item>
        <el-form-item label="市场价" prop="gMarketPrice">
          <el-input type="number" v-model="goodsForm.gMarketPrice"></el-input>
        </el-form-item>
        <el-form-item label="多张详情图">
          <!-- <el-input v-model="goodsForm.gImgs"></el-input> -->
          <el-upload
            class="upload-demo"
            action="/api/file/testuploadimg"
            :on-remove="handleRemove"
            :on-success="foo"
            :file-list="goodsForm.gImgs"
            list-type="picture">
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
          </el-upload>
        </el-form-item>
        <el-form-item label="库存数量" prop="gSoldNum">
          <el-input type="number" v-model="goodsForm.gSoldNum"></el-input>
        </el-form-item>
        <el-form-item label="大标题">
          <el-input v-model="goodsForm.gBigTit"></el-input>
        </el-form-item>
        <el-form-item label="小标题">
          <el-input v-model="goodsForm.gSmallTit"></el-input>
        </el-form-item>
        <el-form-item label="简单介绍">
          <el-input v-model="goodsForm.gShortDes"></el-input>
        </el-form-item>
        <el-form-item label="详细介绍">
          <el-input v-model="goodsForm.gLongDes"></el-input>
        </el-form-item>
        <el-form-item label="规格">
          <el-input v-model="goodsForm.gSpec"></el-input>
        </el-form-item>
        <el-form-item label="状态" prop="resource">
        <el-radio-group v-model="goodsForm.gStatus">
          <el-radio v-model="goodsForm.gStatus" label="1">上架</el-radio>
          <el-radio v-model="goodsForm.gStatus" label="0">下架</el-radio>
        </el-radio-group>
      </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('goodsForm')">立即创建</el-button>
          <el-button @click="cancel()">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
	</div>
</template>
<script>
  import { getCateListPage } from '../../api/api';
	export default {
    props:{
      show:{
        type: Boolean,
        default: false
      }
    },
    data(){
      return{
        dialogFlg :false,
        goodsForm: {
          gName: '',
          gLogo: '',
          gPrice:'',
          gMarketPrice:'',
          gImgs:[],    //多张轮播图
          gSoldNum:'',  //库存
          gBigTit:'',  //大标题
          gSmallTit:'', //小标题
          gShortDes:'', //短简介
          gLongDes:'',  //长简介
          gSpec:'', //规格
          gStatus:'1',  //状态：  1上架   0下架
          cId:'',
        },
        cates:[],
        goodsRules:{
          cId:[{ required: true, message: '请选择分类'}],
          gName:[{ required: true, message: '名称不能为空'}],
          gLogo:[{ required: true, message: '必须上传封面图'}],
          gPrice:[{ required: true, message: '价格不能为空'}],
          gBigTit:[{ required: true, message: '大标题不能为空'}],
        },
        imageUrl: '',
      }
    },
    created(){
      
    },
    watch:{
      show(val){
        this.dialogFlg = val;
        if(this.cates.length == 0 && this.dialogFlg){
          getCateListPage().then(res=>{
            this.cates = res;
          })  
        }
        //this.$emit('update:show-add', val);
      }
    },
    methods:{
      beforeClose(){
        this.dialogFlg = false;
        this.$emit('update:show', false);
      },
      submitForm(formName) {
        var _this = this;
        this.$refs.goodsForm.validate(valid => {
          if (valid) {
            //_this.$router.replace('/table');
            this.logining = true;
            //NProgress.start();
            let imgStr = [];
            this.goodsForm.gImgs.map((v)=>{
              imgStr.push(v.response);
            })
            this.$http.postJson('/api/goods/add',{...this.goodsForm,gImgs:imgStr.join(",")}).then(res => {
              this.logining = false;
            });
            this.$message({
              message: '提交成功',
              type: 'success'
            });
            this.beforeClose();
          } else {
            console.log("error submit!!");
            return false;
          }
        });
      },
      cancel(){
        this.$emit('update:visible',false)
      },
      handleAvatarSuccess(res, file) {  //文件上传成功时的钩子
        //this.goodsForm.gLogo = URL.createObjectURL(file.raw);
        this.goodsForm.gLogo = res;
      },
      beforeAvatarUpload(file) {   //上传文件之前的钩子
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
      },
      handleRemove(file, fileList) {
        this.goodsForm.gImgs = fileList;
      },
      foo(response, file, fileList){
        this.goodsForm.gImgs = fileList;
      }
    }
	}
</script>
<style scope>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 100px;
    height: 100px;
    line-height: 100px;
    text-align: center;
  }
  .avatar {
    width: 100px;
    height: 100px;
    display: block;
  }
  .upload-demo{
    width: 360px;
  }
</style>