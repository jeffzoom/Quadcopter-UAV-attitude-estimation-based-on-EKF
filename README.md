## 基于EKF的四旋翼无人机姿态估计

四旋翼无人机飞行效果的主要还是取决于姿态解算算法与飞行控制方法。

扩展卡尔曼滤波（Extended Kalman Filter，EKF）是标准卡尔曼滤波在非线性情形下的一种扩展形式
EKF算法是将非线性函数进行泰勒展开，省略高阶项，保留展开项的一阶项，以此来实现非线性函数线性化（高维用到雅可比矩阵）
最后通过卡尔曼滤波算法近似计算系统的状态估计值和方差估计值,对信号进行滤波。

![image](https://github.com/jeffzoom/Quadcopter-UAV-attitude-estimation-based-on-EKF/assets/111035313/586f0bcb-2617-42d1-a7ee-df6d1f7a21d8)

![image](https://github.com/jeffzoom/Quadcopter-UAV-attitude-estimation-based-on-EKF/assets/111035313/6166c650-cda0-4e34-b58a-14c29f065c73)

![image](https://github.com/jeffzoom/Quadcopter-UAV-attitude-estimation-based-on-EKF/assets/111035313/d330efe5-e168-41da-846b-c443ae168e09)

真实状态：真实角速度（不可测）
EKF最优估计值：算法估计的角速度
状态测量值：加入高斯噪声（正态分布）之后的传感器测量的角速度
误差值：真实状态 - EKF最优估计值

![image](https://github.com/jeffzoom/Quadcopter-UAV-attitude-estimation-based-on-EKF/assets/111035313/4928926c-1311-490d-a460-efe23934d633)

![image](https://github.com/jeffzoom/Quadcopter-UAV-attitude-estimation-based-on-EKF/assets/111035313/a5f81cd2-3925-4e14-a9c2-014d16745c4f)

![image](https://github.com/jeffzoom/Quadcopter-UAV-attitude-estimation-based-on-EKF/assets/111035313/ad327881-82e9-4b8a-a4b0-0dcd5028a98e)

真实状态：真实角度（不可测）
EKF最优估计值：算法估计的角度
误差值：真实状态 - EKF最优估计值



