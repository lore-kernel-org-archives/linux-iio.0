Return-Path: <SRS0=6Sg8=FQ=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 22 Feb 2018 12:14:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio temperature/mlx90632: silence a static checker warning
Message-ID: <20180222091453.GC9883@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This shouldn't affect runtime at all, but Smatch complains that we
should check if mlx90632_read_ambient_raw() otherwise we
"ambient_new_raw" can be uninitialized.

    drivers/iio/temperature/mlx90632.c:509 mlx90632_calc_ambient_dsp105()
    error: uninitialized symbol 'ambient_new_raw'.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index d695ab97d27f..9851311aa3fd 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -506,6 +506,8 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
 
 	ret = mlx90632_read_ambient_raw(data->regmap, &ambient_new_raw,
 					&ambient_old_raw);
+	if (ret < 0)
+		return ret;
 	*val = mlx90632_calc_temp_ambient(ambient_new_raw, ambient_old_raw,
 					  PT, PR, PG, PO, Gb);
 	return ret;
