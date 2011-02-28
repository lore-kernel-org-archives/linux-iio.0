Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "greg@kroah.com"
	<greg@kroah.com>
Date: Mon, 28 Feb 2011 12:45:29 +0000
Subject: RE: [PATCH] staging: iio: fix spi cs_change behaviour
Message-ID: <544AC56F16B56944AEC3BD4E3D59177133FA5C08CB@LIMKCMBX1.ad.analog.com>
References: <1294826147-30329-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <4D2D911F.3000203@cam.ac.uk>
In-Reply-To: <4D2D911F.3000203@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-01-12:
> On 01/12/11 09:55, Manuel Stahl wrote:
>> The normal behaviour is:
>>  * After all transfers except the last: CS stays active
>>  * After the last transfer: CS goes inactive
>
> Hi Manuel,
>
> Thanks for doing this.
>
> This ideally wants an ack from someone at Analog (Michael perhaps?)
> given it touches so many of their drivers.
>
> I'm not keen on the level of change in the lis3l02dq going in within
> this set. The change looks worthwhile, but it isn't just fixing the
> cs_change problem so it really shouldn't be in this patch.
> We can put that one in place at a later date.
> Same is true for the sca3000 driver.  Please just do the cs_change
> fixes in this patch.
>
> A few cases here remove cases where cs_change is set to 0 anyway.
> Worthy cleanups, but not fixes.  Still those are at least within the
> spirit of the fixes and don't really matter.
>
> Feel free to add my ack to a version with the lis3l02dq and sca3000
> cleanups removed (and appropriate cs_change patches for those two).
>>
>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>>
>> ---
>>  drivers/staging/iio/accel/adis16201_core.c |    4 +-
>>  drivers/staging/iio/accel/adis16201_ring.c |    2 +-
>>  drivers/staging/iio/accel/adis16203_core.c |    4 +-
>>  drivers/staging/iio/accel/adis16203_ring.c |    2 +-
>>  drivers/staging/iio/accel/adis16204_core.c |    4 +-
>>  drivers/staging/iio/accel/adis16204_ring.c |    2 +-
>>  drivers/staging/iio/accel/adis16209_core.c |    4 +-
>>  drivers/staging/iio/accel/adis16209_ring.c |    2 +-
>>  drivers/staging/iio/accel/adis16220_core.c |    6 ++--
>>  drivers/staging/iio/accel/adis16240_core.c |    4 +-
>>  drivers/staging/iio/accel/adis16240_ring.c |    2 +-
>>  drivers/staging/iio/accel/lis3l02dq_core.c |   34 +++++-------------
>>  ---------- drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +++-
>>  drivers/staging/iio/accel/sca3000_core.c   |   15 +----------
>>  drivers/staging/iio/gyro/adis16251_core.c  |    8 +++---
>>  drivers/staging/iio/gyro/adis16260_core.c  |    4 +-
>>  drivers/staging/iio/gyro/adis16260_ring.c  |    2 +-
>>  drivers/staging/iio/imu/adis16300_core.c   |    4 +-
>>  drivers/staging/iio/imu/adis16300_ring.c   |    2 -
>>  drivers/staging/iio/imu/adis16350_core.c   |    4 +-
>>  drivers/staging/iio/imu/adis16350_ring.c   |    2 -
>>  drivers/staging/iio/imu/adis16400_core.c   |    4 +-
>>  drivers/staging/iio/imu/adis16400_ring.c   |    2 - 23 files changed,
>>  43 insertions(+), 79 deletions(-)
>> diff --git a/drivers/staging/iio/accel/adis16201_core.c
>> b/drivers/staging/iio/accel/adis16201_core.c
>> index 79b785a..45fc2c7 100644
>> --- a/drivers/staging/iio/accel/adis16201_core.c
>> +++ b/drivers/staging/iio/accel/adis16201_core.c
>> @@ -80,7 +80,7 @@ static int adis16201_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -125,7 +125,7 @@ static int adis16201_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 20,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/adis16201_ring.c
>> b/drivers/staging/iio/accel/adis16201_ring.c
>> index e6870a2..9f35663 100644
>> --- a/drivers/staging/iio/accel/adis16201_ring.c
>> +++ b/drivers/staging/iio/accel/adis16201_ring.c
>> @@ -97,7 +97,7 @@ static int adis16201_read_ring_data(struct device
> *dev, u8 *rx)
>>      memset(xfers, 0, sizeof(xfers));
>>      for (i =3D 0; i <=3D ADIS16201_OUTPUTS; i++) {
>>              xfers[i].bits_per_word =3D 8;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < ADIS16201_OUTPUTS);
>>              xfers[i].len =3D 2;
>>              xfers[i].delay_usecs =3D 20;
>>              xfers[i].tx_buf =3D st->tx + 2 * i; diff --git
>> a/drivers/staging/iio/accel/adis16203_core.c
>> b/drivers/staging/iio/accel/adis16203_core.c
>> index b57f190..adf7f16 100644
>> --- a/drivers/staging/iio/accel/adis16203_core.c
>> +++ b/drivers/staging/iio/accel/adis16203_core.c
>> @@ -80,7 +80,7 @@ static int adis16203_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -125,7 +125,7 @@ static int adis16203_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 20,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/adis16203_ring.c
>> b/drivers/staging/iio/accel/adis16203_ring.c
>> index 3d774f7..dc71406 100644
>> --- a/drivers/staging/iio/accel/adis16203_ring.c
>> +++ b/drivers/staging/iio/accel/adis16203_ring.c
>> @@ -89,7 +89,7 @@ static int adis16203_read_ring_data(struct device
> *dev, u8 *rx)
>>      memset(xfers, 0, sizeof(xfers));
>>      for (i =3D 0; i <=3D ADIS16203_OUTPUTS; i++) {
>>              xfers[i].bits_per_word =3D 8;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < ADIS16203_OUTPUTS);
>>              xfers[i].len =3D 2;
>>              xfers[i].delay_usecs =3D 20;
>>              xfers[i].tx_buf =3D st->tx + 2 * i; diff --git
>> a/drivers/staging/iio/accel/adis16204_core.c
>> b/drivers/staging/iio/accel/adis16204_core.c
>> index cc15e40..8c40cc3 100644
>> --- a/drivers/staging/iio/accel/adis16204_core.c
>> +++ b/drivers/staging/iio/accel/adis16204_core.c
>> @@ -79,7 +79,7 @@ static int adis16204_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -124,7 +124,7 @@ static int adis16204_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 20,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/adis16204_ring.c
>> b/drivers/staging/iio/accel/adis16204_ring.c
>> index 420b160..fa716b5 100644
>> --- a/drivers/staging/iio/accel/adis16204_ring.c
>> +++ b/drivers/staging/iio/accel/adis16204_ring.c
>> @@ -87,7 +87,7 @@ static int adis16204_read_ring_data(struct device
> *dev, u8 *rx)
>>      memset(xfers, 0, sizeof(xfers));
>>      for (i =3D 0; i <=3D ADIS16204_OUTPUTS; i++) {
>>              xfers[i].bits_per_word =3D 8;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < ADIS16204_OUTPUTS);
>>              xfers[i].len =3D 2;
>>              xfers[i].delay_usecs =3D 20;
>>              xfers[i].tx_buf =3D st->tx + 2 * i; diff --git
>> a/drivers/staging/iio/accel/adis16209_core.c
>> b/drivers/staging/iio/accel/adis16209_core.c
>> index e4ac956..d209df1 100644
>> --- a/drivers/staging/iio/accel/adis16209_core.c
>> +++ b/drivers/staging/iio/accel/adis16209_core.c
>> @@ -82,7 +82,7 @@ static int adis16209_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 30,
>>              },
>>      };
>> @@ -128,7 +128,7 @@ static int adis16209_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 30,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/adis16209_ring.c
>> b/drivers/staging/iio/accel/adis16209_ring.c
>> index 8eba0af..caac15e 100644
>> --- a/drivers/staging/iio/accel/adis16209_ring.c
>> +++ b/drivers/staging/iio/accel/adis16209_ring.c
>> @@ -103,7 +103,7 @@ static int adis16209_read_ring_data(struct
>> device
> *dev, u8 *rx)
>>      memset(xfers, 0, sizeof(xfers));
>>      for (i =3D 0; i <=3D ADIS16209_OUTPUTS; i++) {
>>              xfers[i].bits_per_word =3D 8;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < ADIS16209_OUTPUTS);
>>              xfers[i].len =3D 2;
>>              xfers[i].delay_usecs =3D 30;
>>              xfers[i].tx_buf =3D st->tx + 2 * i; diff --git
>> a/drivers/staging/iio/accel/adis16220_core.c
>> b/drivers/staging/iio/accel/adis16220_core.c
>> index 1c1e98a..f6b4977 100644
>> --- a/drivers/staging/iio/accel/adis16220_core.c
>> +++ b/drivers/staging/iio/accel/adis16220_core.c
>> @@ -77,7 +77,7 @@ static int adis16220_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 35,
>>              },
>>      };
>> @@ -123,7 +123,7 @@ static int adis16220_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 35,
>>              },
>>      };
>> @@ -366,7 +366,7 @@ static ssize_t
> adis16220_capture_buffer_read(struct adis16220_state *st,
>>                      .tx_buf =3D st->tx,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 25,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/adis16240_core.c
>> b/drivers/staging/iio/accel/adis16240_core.c
>> index d11d164..dcd8cb8 100644
>> --- a/drivers/staging/iio/accel/adis16240_core.c
>> +++ b/drivers/staging/iio/accel/adis16240_core.c
>> @@ -80,7 +80,7 @@ static int adis16240_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 35,
>>              },
>>      };
>> @@ -126,7 +126,7 @@ static int adis16240_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 35,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/adis16240_ring.c
>> b/drivers/staging/iio/accel/adis16240_ring.c
>> index f882e9c..5cf2fbf 100644
>> --- a/drivers/staging/iio/accel/adis16240_ring.c
>> +++ b/drivers/staging/iio/accel/adis16240_ring.c
>> @@ -91,7 +91,7 @@ static int adis16240_read_ring_data(struct device
> *dev, u8 *rx)
>>      memset(xfers, 0, sizeof(xfers));
>>      for (i =3D 0; i <=3D ADIS16240_OUTPUTS; i++) {
>>              xfers[i].bits_per_word =3D 8;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < ADIS16240_OUTPUTS);
>>              xfers[i].len =3D 2;
>>              xfers[i].delay_usecs =3D 30;
>>              xfers[i].tx_buf =3D st->tx + 2 * i; diff --git
>> a/drivers/staging/iio/accel/lis3l02dq_core.c
>> b/drivers/staging/iio/accel/lis3l02dq_core.c
>> index c4b4ab7..9a93771 100644
>> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
>> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
>> @@ -53,23 +53,9 @@ int lis3l02dq_spi_read_reg_8(struct device *dev,
> u8 reg_address, u8 *val)
>>      struct iio_sw_ring_helper_state *h =3D iio_dev_get_devdata(indio_de=
v);
>>      struct lis3l02dq_state *st =3D lis3l02dq_h_to_s(h);
>> -    struct spi_transfer xfer =3D {
>> -            .tx_buf =3D st->tx,
>> -            .rx_buf =3D st->rx,
>> -            .bits_per_word =3D 8,
>> -            .len =3D 2,
>> -            .cs_change =3D 1,
>> -    };
>> -
>> -    mutex_lock(&st->buf_lock);
>> -    st->tx[0] =3D LIS3L02DQ_READ_REG(reg_address);
>> -    st->tx[1] =3D 0;
>> -
>> -    spi_message_init(&msg);
>> -    spi_message_add_tail(&xfer, &msg);
>> -    ret =3D spi_sync(st->us, &msg);
>> -    *val =3D st->rx[1];
>> -    mutex_unlock(&st->buf_lock);
>> +    ret =3D spi_w8r8(st->us, LIS3L02DQ_READ_REG(reg_address));
>> +    if (ret >=3D 0)
>> +            *val =3D ret;
>>
>>      return ret; } @@ -90,20 +76,12 @@ int
>>  lis3l02dq_spi_write_reg_8(struct device *dev,       struct
>>  iio_sw_ring_helper_state *h                 =3D iio_dev_get_devdata(ind=
io_dev);
>>      struct lis3l02dq_state *st =3D lis3l02dq_h_to_s(h);
>> -    struct spi_transfer xfer =3D {
>> -            .tx_buf =3D st->tx,
>> -            .bits_per_word =3D 8,
>> -            .len =3D 2,
>> -            .cs_change =3D 1,
>> -    };
>>
>>      mutex_lock(&st->buf_lock);
>>      st->tx[0] =3D LIS3L02DQ_WRITE_REG(reg_address);
>>      st->tx[1] =3D *val;
>> -    spi_message_init(&msg);
>> -    spi_message_add_tail(&xfer, &msg);
>> -    ret =3D spi_sync(st->us, &msg);
>> +    ret =3D spi_write(st->us, st->tx, 2);
>>      mutex_unlock(&st->buf_lock);
>>
>>      return ret;
>> @@ -135,7 +113,7 @@ static int lis3l02dq_spi_write_reg_s16(struct
> device *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -182,7 +160,7 @@ static int lis3l02dq_spi_read_reg_s16(struct
> device *dev,
>>                      .rx_buf =3D st->rx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>
>>              },
>>      };
>> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c
>> b/drivers/staging/iio/accel/lis3l02dq_ring.c
>> index 1fd088a..c33f492 100644
>> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
>> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
>> @@ -262,8 +262,11 @@ static int lis3l02dq_read_all(struct
> lis3l02dq_state *st, u8 *rx_array)
>>       * values in alternate bytes
>>       */
>>      spi_message_init(&msg);
>> -    for (j =3D 0; j < ring->scan_count * 2; j++)
>> +    for (j =3D 0; j < ring->scan_count * 2; j++) {
>> +            if (j =3D=3D ring->scan_count * 2 - 1)
>> +                    xfers[j].cs_change =3D 0;
>>              spi_message_add_tail(&xfers[j], &msg);
>> +    }
>>
>>      ret =3D spi_sync(st->us, &msg);
>>      mutex_unlock(&st->buf_lock);
>> diff --git a/drivers/staging/iio/accel/sca3000_core.c
>> b/drivers/staging/iio/accel/sca3000_core.c
>> index 5b06dea..5ff8a8a 100644
>> --- a/drivers/staging/iio/accel/sca3000_core.c
>> +++ b/drivers/staging/iio/accel/sca3000_core.c
>> @@ -75,20 +75,10 @@ static const struct sca3000_chip_info
>> sca3000_spi_chip_info_tbl[] =3D {
>>
>>  int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
>> {
>> -    struct spi_transfer xfer =3D {
>> -            .bits_per_word =3D 8,
>> -            .len =3D 2,
>> -            .cs_change =3D 1,
>> -            .tx_buf =3D st->tx,
>> -    };
>> -    struct spi_message msg;
>> -
>>      st->tx[0] =3D SCA3000_WRITE_REG(address);
>>      st->tx[1] =3D val;
>> -    spi_message_init(&msg);
>> -    spi_message_add_tail(&xfer, &msg);
>>
>> -    return spi_sync(st->us, &msg);
>> +    return spi_write(st->us, st->tx, 2);
>>  }
>>
>>  int sca3000_read_data(struct sca3000_state *st, @@ -101,7 +91,6 @@ int
>>  sca3000_read_data(struct sca3000_state *st,         struct spi_transfer=
 xfer
>>  =3D {                 .bits_per_word =3D 8,             .len =3D len + =
1, -               .cs_change =3D 1,
>>              .tx_buf =3D st->tx,       };
>> @@ -173,7 +162,7 @@ static int __sca3000_unlock_reg_lock(struct
> sca3000_state *st)
>>              }, {
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .tx_buf =3D st->tx + 4,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/gyro/adis16251_core.c
>> b/drivers/staging/iio/gyro/adis16251_core.c
>> index a0d400f..9a2ef36 100644
>> --- a/drivers/staging/iio/gyro/adis16251_core.c
>> +++ b/drivers/staging/iio/gyro/adis16251_core.c
>> @@ -81,7 +81,7 @@ static int adis16251_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -125,7 +125,7 @@ static int adis16251_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -174,7 +174,7 @@ int adis16251_spi_read_burst(struct device *dev,
> u8 *rx)
>>                      .rx_buf =3D rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 24,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -231,7 +231,7 @@ int adis16251_spi_read_sequence(struct device
> *dev,
>>                      xfers[i].tx_buf =3D st->tx + 2*i;
>>              xfers[i].bits_per_word =3D 8;
>>              xfers[i].len =3D 2;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < num);
>>              spi_message_add_tail(&xfers[i], &msg);
>>      }
>> diff --git a/drivers/staging/iio/gyro/adis16260_core.c
>> b/drivers/staging/iio/gyro/adis16260_core.c
>> index 045e27d..cd1fbf6 100644
>> --- a/drivers/staging/iio/gyro/adis16260_core.c
>> +++ b/drivers/staging/iio/gyro/adis16260_core.c
>> @@ -80,7 +80,7 @@ static int adis16260_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 20,
>>              },
>>      };
>> @@ -126,7 +126,7 @@ static int adis16260_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 30,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c
>> b/drivers/staging/iio/gyro/adis16260_ring.c
>> index 2342889..79e50c7 100644
>> --- a/drivers/staging/iio/gyro/adis16260_ring.c
>> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
>> @@ -90,7 +90,7 @@ static int adis16260_read_ring_data(struct device
> *dev, u8 *rx)
>>      memset(xfers, 0, sizeof(xfers));
>>      for (i =3D 0; i <=3D ADIS16260_OUTPUTS; i++) {
>>              xfers[i].bits_per_word =3D 8;
>> -            xfers[i].cs_change =3D 1;
>> +            xfers[i].cs_change =3D (i < ADIS16260_OUTPUTS);
>>              xfers[i].len =3D 2;
>>              xfers[i].delay_usecs =3D 30;
>>              xfers[i].tx_buf =3D st->tx + 2 * i; diff --git
>> a/drivers/staging/iio/imu/adis16300_core.c
>> b/drivers/staging/iio/imu/adis16300_core.c
>> index 7ad13f4..5c651ca 100644
>> --- a/drivers/staging/iio/imu/adis16300_core.c
>> +++ b/drivers/staging/iio/imu/adis16300_core.c
>> @@ -82,7 +82,7 @@ static int adis16300_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 75,
>>              },
>>      };
>> @@ -128,7 +128,7 @@ static int adis16300_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 75,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/imu/adis16300_ring.c
>> b/drivers/staging/iio/imu/adis16300_ring.c
>> index 114fdf4..1627354 100644
>> --- a/drivers/staging/iio/imu/adis16300_ring.c
>> +++ b/drivers/staging/iio/imu/adis16300_ring.c
>> @@ -114,12 +114,10 @@ static int adis16300_spi_read_burst(struct
> device *dev, u8 *rx)
>>                      .tx_buf =3D st->tx,                       .bits_per=
_word =3D 8,                     .len =3D 2,
>>  -                   .cs_change =3D 0,                 }, {             =
       .rx_buf =3D rx,                   .bits_per_word =3D 8,
>>                      .len =3D 18, -                    .cs_change =3D 0,=
                 },      };
>> diff --git a/drivers/staging/iio/imu/adis16350_core.c
>> b/drivers/staging/iio/imu/adis16350_core.c
>> index cf7176b..09f0691 100644
>> --- a/drivers/staging/iio/imu/adis16350_core.c
>> +++ b/drivers/staging/iio/imu/adis16350_core.c
>> @@ -81,7 +81,7 @@ static int adis16350_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 35,
>>              },
>>      };
>> @@ -127,7 +127,7 @@ static int adis16350_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>                      .delay_usecs =3D 35,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/imu/adis16350_ring.c
>> b/drivers/staging/iio/imu/adis16350_ring.c
>> index 56b70cf..3653d8c 100644
>> --- a/drivers/staging/iio/imu/adis16350_ring.c
>> +++ b/drivers/staging/iio/imu/adis16350_ring.c
>> @@ -110,12 +110,10 @@ static int adis16350_spi_read_burst(struct
> device *dev, u8 *rx)
>>                      .tx_buf =3D st->tx,                       .bits_per=
_word =3D 8,                     .len =3D 2,
>>  -                   .cs_change =3D 0,                 }, {             =
       .rx_buf =3D rx,                   .bits_per_word =3D 8,
>>                      .len =3D 22, -                    .cs_change =3D 0,=
                 },      };
> Technically this one doesn't change anything..
>>
>> diff --git a/drivers/staging/iio/imu/adis16400_core.c
>> b/drivers/staging/iio/imu/adis16400_core.c
>> index cfb108a..1a60a5e 100644
>> --- a/drivers/staging/iio/imu/adis16400_core.c
>> +++ b/drivers/staging/iio/imu/adis16400_core.c
>> @@ -93,7 +93,7 @@ static int adis16400_spi_write_reg_16(struct
>> device
> *dev,
>>                      .tx_buf =3D st->tx + 2,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> @@ -137,7 +137,7 @@ static int adis16400_spi_read_reg_16(struct
> device *dev,
>>                      .rx_buf =3D st->rx,
>>                      .bits_per_word =3D 8,
>>                      .len =3D 2,
>> -                    .cs_change =3D 1,
>> +                    .cs_change =3D 0,
>>              },
>>      };
>> diff --git a/drivers/staging/iio/imu/adis16400_ring.c
>> b/drivers/staging/iio/imu/adis16400_ring.c
>> index 33293fb..ac381ca 100644
>> --- a/drivers/staging/iio/imu/adis16400_ring.c
>> +++ b/drivers/staging/iio/imu/adis16400_ring.c
>> @@ -122,12 +122,10 @@ static int adis16400_spi_read_burst(struct
> device *dev, u8 *rx)
>>                      .tx_buf =3D st->tx,                       .bits_per=
_word =3D 8,                     .len =3D 2,
>>  -                   .cs_change =3D 0,                 }, {             =
       .rx_buf =3D rx,                   .bits_per_word =3D 8,
>>                      .len =3D 24, -                    .cs_change =3D 1,=
                 },      };
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
