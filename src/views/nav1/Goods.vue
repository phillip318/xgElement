<template>
	<el-form ref="goodsForm" :rules="goodsRules" :model="goodsForm" label-width="100px" @submit.prevent="submitForm" style="margin:20px;width:60%;min-width:600px;">
		<el-form-item label="商品名称">
			<el-input v-model="goodsForm.gName"></el-input>
		</el-form-item>
    <el-form-item label="所属分类">
      <el-select v-model="cId" placeholder="请选择">
        <el-option
          v-for="item in cates"
          :key="item.cId"
          :label="item.cName"
          :value="item.cId">
        </el-option>
      </el-select>
    </el-form-item>
		<el-form-item label="商品封面图">
			<el-input v-model.number="goodsForm.gLogo"></el-input>
		</el-form-item>
    <el-form-item label="促销价" prop="gPrice">
			<el-input type="number" v-model="goodsForm.gPrice"></el-input>
		</el-form-item>
    <el-form-item label="市场价" prop="gMarketPrice">
			<el-input type="number" v-model="goodsForm.gMarketPrice"></el-input>
		</el-form-item>
    <el-form-item label="多张详情图">
      <el-input v-model="goodsForm.gImgs"></el-input>
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
			<el-button @click.native.prevent>取消</el-button>
		</el-form-item>
	</el-form>
</template>

<script>
  import { getCateListPage } from '../../api/api';

	export default {
		data() {
			return {
        goodsRules:{
          // gPrice:[{ type: 'number', message: '必须为数字值'}],
          // gMarketPrice:[{ type: 'number', message: '必须为数字值'}],
          // gSoldNum:[{ type: 'number', message: '必须为数字值'}]
        },
				goodsForm: {
					gName: '',
					gLogo: '',
          gPrice:'',
          gMarketPrice:'',
          gImgs:'',    //多张轮播图
          gSoldNum:'',  //库存
          gBigTit:'',  //大标题
          gSmallTit:'', //小标题
          gShortDes:'', //短简介
          gLongDes:'',  //长简介
          gSpec:'', //规格
          gStatus:'1'  //状态：  1上架   0下架
				},
        cId:'',
        cates:[]
			}
		},
    mounted(){
      getCateListPage().then(res=>{
        this.cates = res;
      })
    },
		methods: {
			submitForm(formName) {
        var _this = this;
        this.$refs.goodsForm.validate(valid => {
          if (valid) {
            //_this.$router.replace('/table');
            this.logining = true;
            //NProgress.start();
            this.goodsForm.cId = this.cId;
            console.log(this.goodsForm)
            this.$http.postJson('/api/goods/add',this.goodsForm).then(res => {
              this.logining = false;
            });
            this.$message({
              message: '提交成功',
              type: 'success'
            });
          } else {
            console.log("error submit!!");
            return false;
          }
        });
			}
		}
	}

</script>