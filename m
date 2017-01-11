Return-Path: <SRS0=3L/s=YZ=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Wed, 11 Jan 2017 14:39:59 +0000
In-Reply-To: <20170111104839.11129-1-linus.walleij@linaro.org>
References: <20170111104839.11129-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio: inkern: pass through raw values if no scaling
To: Linus Walleij <linus.walleij@linaro.org>,Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <BD7195F1-A9E6-4538-840D-25A2AAC5D850@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 11 January 2017 10:48:39 GMT+00:00, Linus Walleij <linus=2Ewalleij@lina=
ro=2Eorg> wrote:
>When a consumer calls iio_read_channel_processed() the IIO core
>tries to apply scaling to the value, but if the channel only
>supports reading raw values, we should return that raw value
>to the cosumer instead of an error=2E
>
>This is what userspace is expected to do with sensors only
>providing raw values so the kernel should do the same, so as to
>avoid adding scaling boilerplate to drivers for hardware that
>actually return processed values from raw reads=2E
Hmm=2E I guess this is reasonable as it would be correct to have a raw val=
ue if the scale was 1
 and hence not supplied, but there was an offset
If neither is supplied so scale is 1 and offset 0=20
then having it as raw is a bug=2E

Come to think of it the raw element is only useful on the case where we ha=
ve no known units=2E
Otherwise the absence of offset and scale alone would indicate a processed=
 value=2E

Upshot is I agree with change but might add info to patch message when I a=
pply it=2E  Arguably
 userspace should be specifically indicating that there is no known transf=
orm (perhaps by not
 listing units) rather than sweeping it under the carpet=2E  This is perfe=
ctly valid for many intensity
 of reflection proximity sensors where the meaning of the value is dependa=
nt on the material which we can't know=2E


Fun fun fun=20

Jonathan
>
>Signed-off-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>---
> drivers/iio/inkern=2Ec | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iio/inkern=2Ec b/drivers/iio/inkern=2Ec
>index b0f4630a163f=2E=2E7a13535dc3e9 100644
>--- a/drivers/iio/inkern=2Ec
>+++ b/drivers/iio/inkern=2Ec
>@@ -601,8 +601,14 @@ static int
>iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>=20
> 	scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> 					IIO_CHAN_INFO_SCALE);
>-	if (scale_type < 0)
>-		return scale_type;
>+	if (scale_type < 0) {
>+		/*
>+		 * Just pass raw values as processed if no scaling is
>+		 * available=2E
>+		 */
>+		*processed =3D raw;
>+		return 0;
>+	}
>=20
> 	switch (scale_type) {
> 	case IIO_VAL_INT:

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
