<template>
  <div>
    <!--工具条-->
    <el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
      <el-form :inline="true" :model="gFilters">
        <el-form-item>
          <el-input v-model="gFilters.name" placeholder="商品名称"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary">查询</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="openAdd">新增</el-button>
        </el-form-item>
      </el-form>
    </el-col>
    <!--列表-->
    <el-table :data="goods" highlight-current-row v-loading="listLoading" style="width: 100%;">
      <el-table-column type="selection" width="55">
      </el-table-column>
      <el-table-column type="index" width="60">
      </el-table-column>
      <el-table-column prop="gId" label="商品ID" width="220" sortable v-if="false">
      </el-table-column>
      </el-table-column>
      <el-table-column prop="cId" label="分类ID" width="220" sortable v-if="false">
      </el-table-column>
      <el-table-column prop="cName" label="分类名称" width="120" sortable>
      </el-table-column>
      <el-table-column prop="gName" label="商品名称" width="120" >
      </el-table-column>
      <el-table-column prop="gLogo" label="商品封面图" width="180" >
        <template slot-scope="scope">
          <img :src="scope.row.gLogo" alt="" style="width: 50px;height: 50px">
        </template>
      </el-table-column>
      <el-table-column prop="gPrice" label="门店价" width="100" >
      </el-table-column>
      <el-table-column prop="gMarketPrice" label="市场价" width="100" >
      </el-table-column>
      <el-table-column prop="gImgs" label="详细轮播图" width="100" :show-overflow-tooltip="true" v-if="true">
      </el-table-column>
      <el-table-column prop="gSoldNum" label="已售" width="100" >
      </el-table-column>
      <el-table-column prop="gBigTit" label="大标题" width="100" >
      </el-table-column>
      <el-table-column prop="gSmallTit" label="小标题" width="100" >
      </el-table-column>
      <el-table-column prop="gShortDes" label="简单介绍" width="100" >
      </el-table-column>
      <el-table-column prop="gLongDes" label="详细介绍" width="100" >
      </el-table-column>
      <el-table-column prop="gSpec" label="规格" width="100" >
      </el-table-column>
      <el-table-column prop="gStatus" label="状态" width="100" >
      </el-table-column>
      <el-table-column label="操作" width="150">
        <template scope="scope">
          <el-button size="small" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button type="danger" size="small" @click="handleDel(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--新增界面-->
    <goods-add :show.sync="addFlg"></goods-add>
    
  </div>
</template>

<script>
  import GoodsAdd from './GoodsAdd';
  import { getGoodsListPage} from '../../api/api';
	export default {
    components:{
      GoodsAdd
    },
		data() {
			return {
        gFilters:{

        },
        goods:[],
        total: 0,
        page: 1,
        addFlg:false, //是否弹出添加页面
			}
		},
    created(){
      //获取商品列表
      this.getGoods();
    },
		methods: {
		  openAdd(){
        this.addFlg = true;
      },
      getGoods(){
        this.listLoading = true;
        //NProgress.start();
        getGoodsListPage().then((res) => {
          //this.total = res.data.total;
          this.goods = res;
          this.listLoading = false;
        });
      },
		}
	}

</script>