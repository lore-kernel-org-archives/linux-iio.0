Return-Path: <viorel.suman@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1502162216450.27470@pmeerw.net>
References: <1424120983-21399-1-git-send-email-viorel.suman@gmail.com>
	<alpine.DEB.2.02.1502162216450.27470@pmeerw.net>
Date: Tue, 17 Feb 2015 00:04:24 +0200
Message-ID: <CAAH5R_MnQMzcWYbs5mu2Dis0G0v_nKWRbTcZ8iyOvqbQJptRJw@mail.gmail.com>
Subject: Re: [PATCH] Clear timestamp kfifo on trigger enabling
From: Viorel Suman <viorel.suman@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1135510ceee378050f3bc455
List-ID: <linux-iio@vger.kernel.org>

--001a1135510ceee378050f3bc455
Content-Type: text/plain; charset=UTF-8

Hi Peter, All

Thank you for quick review. As an alternative I'm considering calling
inv_clear_kfifo(st); from inv_reset_fifo(indio_dev); - it makes more sense
to me
now given that the timestaps in kfifo are invalid once the hardware fifo is
reset.

I'll upload a new patch shortly.

Thank you,
/Viorel


On Mon, Feb 16, 2015 at 11:21 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:

>
> > The timestamp kfifo must be cleared once the
> > hardware fifo is reset, thus are removed
> > timestamps related to unprocessed events from
> > hardware fifo - see "inv_mpu6050_read_fifo"
> > method implementation.
>
> comments below
> a prefix iio: in the subject would be nice
>
> > Signed-off-by: Viorel Suman <viorel.suman@gmail.com>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 28
> +++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > index 926fcce..b617920 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -42,57 +42,61 @@ static void inv_scan_query(struct iio_dev *indio_dev)
> >  static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool
> enable)
> >  {
> >       struct inv_mpu6050_state *st = iio_priv(indio_dev);
> > -     int result;
> > +     int result = 0;
>
> no need to init result
>
> the mutex could be obtained in the caller, i.e.
> inv_mpu_data_rdy_trigger_set_state(), simplifying the code and drastically
> reducing the size of this patch
>
> the patch description does not explain a mutex is (now?) needed; probably
> this should be split out as a separate patch
>
> >
> > +     mutex_lock(&indio_dev->mlock);
> >       if (enable) {
> >               result = inv_mpu6050_set_power_itg(st, true);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >               inv_scan_query(indio_dev);
> >               if (st->chip_config.gyro_fifo_enable) {
> >                       result = inv_mpu6050_switch_engine(st, true,
> >                                       INV_MPU6050_BIT_PWR_GYRO_STBY);
> >                       if (result)
> > -                             return result;
> > +                             goto write_error;
> >               }
> >               if (st->chip_config.accl_fifo_enable) {
> >                       result = inv_mpu6050_switch_engine(st, true,
> >                                       INV_MPU6050_BIT_PWR_ACCL_STBY);
> >                       if (result)
> > -                             return result;
> > +                             goto write_error;
> >               }
> > +             inv_clear_kfifo(st);
> >               result = inv_reset_fifo(indio_dev);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >       } else {
> >               result = inv_mpu6050_write_reg(st, st->reg->fifo_en, 0);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >
> >               result = inv_mpu6050_write_reg(st, st->reg->int_enable, 0);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >
> >               result = inv_mpu6050_write_reg(st, st->reg->user_ctrl, 0);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >
> >               result = inv_mpu6050_switch_engine(st, false,
> >                                       INV_MPU6050_BIT_PWR_GYRO_STBY);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >
> >               result = inv_mpu6050_switch_engine(st, false,
> >                                       INV_MPU6050_BIT_PWR_ACCL_STBY);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >               result = inv_mpu6050_set_power_itg(st, false);
> >               if (result)
> > -                     return result;
> > +                     goto write_error;
> >       }
> >       st->chip_config.enable = enable;
> > +write_error:
> > +     mutex_unlock(&indio_dev->mlock);
> >
> > -     return 0;
> > +     return result;
> >  }
> >
> >  /**
> >
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
>

--001a1135510ceee378050f3bc455
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBQZXRlciwgQWxsPGJyPjxicj48L2Rpdj48ZGl2PlRoYW5r
IHlvdSBmb3IgcXVpY2sgcmV2aWV3LiBBcyBhbiBhbHRlcm5hdGl2ZSBJJiMzOTttIGNvbnNpZGVy
aW5nIGNhbGxpbmc8YnI+aW52X2NsZWFyX2tmaWZvKHN0KTsgZnJvbSBpbnZfcmVzZXRfZmlmbyhp
bmRpb19kZXYpOyAtIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gbWU8YnI+PC9kaXY+PGRpdj5ub3cg
Z2l2ZW4gdGhhdCB0aGUgdGltZXN0YXBzIGluIGtmaWZvIGFyZSBpbnZhbGlkIG9uY2UgdGhlIGhh
cmR3YXJlIGZpZm8gaXMgcmVzZXQuPGJyPjxicj48L2Rpdj48ZGl2PkkmIzM5O2xsIHVwbG9hZCBh
IG5ldyBwYXRjaCBzaG9ydGx5Ljxicj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UsPGJyPjwvZGl2
PjxkaXY+L1Zpb3JlbDxicj48L2Rpdj7CoDxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBNb24sIEZlYiAxNiwgMjAxNSBhdCAx
MToyMSBQTSwgUGV0ZXIgTWVlcndhbGQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWls
dG86cG1lZXJ3QHBtZWVydy5uZXQiIHRhcmdldD0iX2JsYW5rIj5wbWVlcndAcG1lZXJ3Lm5ldDwv
YT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9IiI+PGJyPg0KJmd0OyBUaGUgdGltZXN0YW1wIGtmaWZv
IG11c3QgYmUgY2xlYXJlZCBvbmNlIHRoZTxicj4NCiZndDsgaGFyZHdhcmUgZmlmbyBpcyByZXNl
dCwgdGh1cyBhcmUgcmVtb3ZlZDxicj4NCiZndDsgdGltZXN0YW1wcyByZWxhdGVkIHRvIHVucHJv
Y2Vzc2VkIGV2ZW50cyBmcm9tPGJyPg0KJmd0OyBoYXJkd2FyZSBmaWZvIC0gc2VlICZxdW90O2lu
dl9tcHU2MDUwX3JlYWRfZmlmbyZxdW90Ozxicj4NCiZndDsgbWV0aG9kIGltcGxlbWVudGF0aW9u
Ljxicj4NCjxicj4NCjwvc3Bhbj5jb21tZW50cyBiZWxvdzxicj4NCmEgcHJlZml4IGlpbzogaW4g
dGhlIHN1YmplY3Qgd291bGQgYmUgbmljZTxicj4NCjxzcGFuIGNsYXNzPSIiPjxicj4NCiZndDsg
U2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuICZsdDs8YSBocmVmPSJtYWlsdG86dmlvcmVsLnN1
bWFuQGdtYWlsLmNvbSI+dmlvcmVsLnN1bWFuQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyAt
LS08YnI+DQomZ3Q7wqAgZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dl
ci5jIHwgMjggKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tPGJyPg0KJmd0O8KgIDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSk8YnI+DQomZ3Q7PGJyPg0K
Jmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJp
Z2dlci5jIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5jPGJy
Pg0KJmd0OyBpbmRleCA5MjZmY2NlLi5iNjE3OTIwIDEwMDY0NDxicj4NCiZndDsgLS0tIGEvZHJp
dmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfdHJpZ2dlci5jPGJyPg0KJmd0OyArKysg
Yi9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV90cmlnZ2VyLmM8YnI+DQomZ3Q7
IEBAIC00Miw1NyArNDIsNjEgQEAgc3RhdGljIHZvaWQgaW52X3NjYW5fcXVlcnkoc3RydWN0IGlp
b19kZXYgKmluZGlvX2Rldik8YnI+DQomZ3Q7wqAgc3RhdGljIGludCBpbnZfbXB1NjA1MF9zZXRf
ZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIGJvb2wgZW5hYmxlKTxicj4NCiZndDvC
oCB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgc3RydWN0IGludl9tcHU2MDUwX3N0YXRlICpzdCA9IGlp
b19wcml2KGluZGlvX2Rldik7PGJyPg0KJmd0OyAtwqAgwqAgwqBpbnQgcmVzdWx0Ozxicj4NCiZn
dDsgK8KgIMKgIMKgaW50IHJlc3VsdCA9IDA7PGJyPg0KPGJyPg0KPC9zcGFuPm5vIG5lZWQgdG8g
aW5pdCByZXN1bHQ8YnI+DQo8YnI+DQp0aGUgbXV0ZXggY291bGQgYmUgb2J0YWluZWQgaW4gdGhl
IGNhbGxlciwgaS5lLjxicj4NCmludl9tcHVfZGF0YV9yZHlfdHJpZ2dlcl9zZXRfc3RhdGUoKSwg
c2ltcGxpZnlpbmcgdGhlIGNvZGUgYW5kIGRyYXN0aWNhbGx5PGJyPg0KcmVkdWNpbmcgdGhlIHNp
emUgb2YgdGhpcyBwYXRjaDxicj4NCjxicj4NCnRoZSBwYXRjaCBkZXNjcmlwdGlvbiBkb2VzIG5v
dCBleHBsYWluIGEgbXV0ZXggaXMgKG5vdz8pIG5lZWRlZDsgcHJvYmFibHk8YnI+DQp0aGlzIHNo
b3VsZCBiZSBzcGxpdCBvdXQgYXMgYSBzZXBhcmF0ZSBwYXRjaDxicj4NCjxkaXYgY2xhc3M9IkhP
RW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj4NCiZndDs8YnI+DQomZ3Q7ICvCoCDCoCDCoG11dGV4
X2xvY2soJmFtcDtpbmRpb19kZXYtJmd0O21sb2NrKTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAo
ZW5hYmxlKSB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzdWx0ID0gaW52X21w
dTYwNTBfc2V0X3Bvd2VyX2l0ZyhzdCwgdHJ1ZSk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKHJlc3VsdCk8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiByZXN1bHQ7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBnb3RvIHdyaXRlX2Vycm9yOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlu
dl9zY2FuX3F1ZXJ5KGluZGlvX2Rldik7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKHN0LSZndDtjaGlwX2NvbmZpZy5neXJvX2ZpZm9fZW5hYmxlKSB7PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzdWx0ID0gaW52X21wdTYwNTBfc3dpdGNo
X2VuZ2luZShzdCwgdHJ1ZSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJTlZfTVBVNjA1MF9CSVRfUFdSX0dZUk9fU1RC
WSk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlc3Vs
dCk8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiByZXN1bHQ7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBnb3RvIHdyaXRlX2Vycm9yOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3QtJmd0O2NoaXBf
Y29uZmlnLmFjY2xfZmlmb19lbmFibGUpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXN1bHQgPSBpbnZfbXB1NjA1MF9zd2l0Y2hfZW5naW5lKHN0LCB0cnVl
LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoElOVl9NUFU2MDUwX0JJVF9QV1JfQUNDTF9TVEJZKTs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmVzdWx0KTxicj4NCiZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJlc3VsdDs8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdv
dG8gd3JpdGVfZXJyb3I7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaW52X2NsZWFyX2tmaWZvKHN0KTs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHQgPSBpbnZfcmVzZXRfZmlmbyhpbmRpb19kZXYpOzxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXN1bHQpPGJyPg0KJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmVzdWx0Ozxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byB3cml0ZV9lcnJvcjs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqB9IGVsc2Ugezxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3Vs
dCA9IGludl9tcHU2MDUwX3dyaXRlX3JlZyhzdCwgc3QtJmd0O3JlZy0mZ3Q7Zmlmb19lbiwgMCk7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlc3VsdCk8YnI+DQomZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiByZXN1bHQ7PGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIHdyaXRlX2Vycm9yOzxicj4NCiZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHQgPSBpbnZfbXB1NjA1MF93
cml0ZV9yZWcoc3QsIHN0LSZndDtyZWctJmd0O2ludF9lbmFibGUsIDApOzxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXN1bHQpPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmVzdWx0Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZ290byB3cml0ZV9lcnJvcjs8YnI+DQomZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzdWx0ID0gaW52X21wdTYwNTBfd3JpdGVfcmVnKHN0LCBz
dC0mZ3Q7cmVnLSZndDt1c2VyX2N0cmwsIDApOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChyZXN1bHQpPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gcmVzdWx0Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ290byB3cml0ZV9lcnJvcjs8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmVzdWx0ID0gaW52X21wdTYwNTBfc3dpdGNoX2VuZ2luZShzdCwgZmFsc2UsPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgSU5WX01QVTYwNTBfQklUX1BXUl9HWVJPX1NUQlkpOzxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChyZXN1bHQpPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gcmVzdWx0Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byB3cml0ZV9lcnJvcjs8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmVzdWx0ID0gaW52X21wdTYwNTBfc3dpdGNoX2VuZ2luZShzdCwgZmFs
c2UsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgSU5WX01QVTYwNTBfQklUX1BXUl9BQ0NMX1NUQlkpOzxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXN1bHQpPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmVzdWx0Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byB3cml0ZV9lcnJvcjs8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXN1bHQgPSBpbnZfbXB1NjA1MF9zZXRfcG93ZXJfaXRnKHN0LCBmYWxz
ZSk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlc3VsdCk8YnI+DQomZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiByZXN1bHQ7PGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIHdyaXRlX2Vycm9yOzxicj4N
CiZndDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7wqAgwqAgwqAgwqBzdC0mZ3Q7Y2hpcF9jb25maWcu
ZW5hYmxlID0gZW5hYmxlOzxicj4NCiZndDsgK3dyaXRlX2Vycm9yOjxicj4NCiZndDsgK8KgIMKg
IMKgbXV0ZXhfdW5sb2NrKCZhbXA7aW5kaW9fZGV2LSZndDttbG9jayk7PGJyPg0KJmd0Ozxicj4N
CiZndDsgLcKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KJmd0OyArwqAgwqAgwqByZXR1cm4gcmVzdWx0
Ozxicj4NCiZndDvCoCB9PGJyPg0KJmd0Ozxicj4NCiZndDvCoCAvKio8YnI+DQomZ3Q7PGJyPg0K
PGJyPg0KLS08YnI+DQo8YnI+DQo8L2Rpdj48L2Rpdj48c3BhbiBjbGFzcz0iSE9FblpiIj48Zm9u
dCBjb2xvcj0iIzg4ODg4OCI+UGV0ZXIgTWVlcndhbGQ8YnI+DQo8YSBocmVmPSJ0ZWw6JTJCNDMt
NjY0LTI0NDQ0MTgiIHZhbHVlPSIrNDM2NjQyNDQ0NDE4Ij4rNDMtNjY0LTI0NDQ0MTg8L2E+wqAo
bW9iaWxlKTxicj4NCjwvZm9udD48L3NwYW4+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4N
Cg==
--001a1135510ceee378050f3bc455--
