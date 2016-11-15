Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 15 Nov 2016 14:02:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: eraretuya@gmail.com, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] staging: iio: ad9832: clean-up regulator 'reg'
Message-ID: <20161115110212.GA776@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

[ This patch generates a GCC warning as well...  I have no idea how we
  failed so badly.  -dan ]

Hello Eva Rachel Retuya,

The patch 43a07e48af44: "staging: iio: ad9832: clean-up regulator
'reg'" from Nov 1, 2016, leads to the following static checker
warning:

	drivers/staging/iio/frequency/ad9832.c:214 ad9832_probe()
	error: potentially dereferencing uninitialized 'st'.

drivers/staging/iio/frequency/ad9832.c
   202  static int ad9832_probe(struct spi_device *spi)
   203  {
   204          struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
   205          struct iio_dev *indio_dev;
   206          struct ad9832_state *st;
   207          int ret;
   208  
   209          if (!pdata) {
   210                  dev_dbg(&spi->dev, "no platform data?\n");
   211                  return -ENODEV;
   212          }
   213  
   214          st->avdd = devm_regulator_get(&spi->dev, "avdd");
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Oops.

   215          if (IS_ERR(st->avdd))
   216                  return PTR_ERR(st->avdd);
   217  
   218          ret = regulator_enable(st->avdd);
   219          if (ret) {
   220                  dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
   221                  return ret;
   222          }
   223  
   224          st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
   225          if (IS_ERR(st->dvdd)) {
   226                  ret = PTR_ERR(st->dvdd);
   227                  goto error_disable_avdd;
   228          }
   229  
   230          ret = regulator_enable(st->dvdd);
   231          if (ret) {
   232                  dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
   233                  goto error_disable_avdd;
   234          }
   235  
   236          indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
   237          if (!indio_dev) {
   238                  ret = -ENOMEM;
   239                  goto error_disable_dvdd;
   240          }
   241          spi_set_drvdata(spi, indio_dev);
   242          st = iio_priv(indio_dev);
                ^^^^^^^^^^^^^^^^^^^^^^^^
"st" isn't initialized until here.


   243          st->mclk = pdata->mclk;
   244          st->spi = spi;


regards,
dan carpenter
