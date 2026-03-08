Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8F336EEE
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772966263; cv=none; b=C11ATxZoSNCbO6wfv+J2YT7IGg1OZmdYXk1oPogtFpLyeqJgSkv84MRexjYkjnD6Xi486NPHDTVfVI/QyeaE1nnz+mCMwGcVyPnjw6/9wbqfzlF+xoDLvafQw0NyH3dJxESNWWw5jDawoSiE7RakOO20HQ0KCgR3MWYwOySGil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772966263; c=relaxed/simple;
	bh=JGh/EawtrGXYsy2nV7dg8XDFbkaVGu437XvYv3o2dP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGHdh27070QX0Zu/mUI+/2ki4wAAuVQ86+cMpnLbDl6o+ars6phxu2/HdY/6JaWwflFsoi1bNyOKsgZ8nqLVjKWUzVg/9VZMLotBsPIzGM4PLIla3/LZsJSXmHkRKKm/qmf7WQ4jOHCkxLzlJVpGkLQp3mvN4dATNIlWhBrbt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986a347d4bso104133247b3.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 03:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772966261; x=1773571061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KYj+s9D/DT9mZv4wKV1OKOm1dIIDZ/HAiRQ1DKpalWw=;
        b=OzuHnCnBxySJzunTBu5NDVwtcJ0Q5xPTV+tFuPpi/iCCzGFv1qN4QK1kU61331546R
         9bLRu/ppd0FCjf6MzB5elV+/aDsuRLg/1i8fUW/w28IR2rvoCDtyytzp1MA8DDUTZed8
         PxjL7YqJk6GKRczFMuXwqeDjkDQ3fAT4RikruN7p7SLysOsr7tMP55NJlo7RU8OTeNv6
         aV0FXvkE7ZAX8Lx8LsxzdKPqvhWann9e00x9YipqqOL3PW+YRVq+DMwTjFNtGVh1bLC0
         XpZzXIBVbTeYqdyJ7mUO4jvrwWabKSVBTl9/ktQNUL4iv2UgAgNrnMEphmAkckcvbQHp
         vYfA==
X-Gm-Message-State: AOJu0YxCdpe0LQMKi4CPJ1y8+ksAgKDAEfv4HQ7bibn8VS5st2xQO7Dr
	gNlI1X0KopHySIou5TIegY5IIVMoSK/lsHe1BllnupoKtL+3XQM4piCKeU60p8hyhZI=
X-Gm-Gg: ATEYQzyke8r/pKv647lxnA4y0sq3sCp6+7rMOWQrLovpTzRmpJ9wwNGGsmri7ou7SzJ
	9f3P170c4SUMgI05AZ496Y2lw56lVEInwwL/wrPHc6LdsPQaD+rt9iTgorWO4G8hJM2WF+GGfWk
	3wIBmhBsoO3FNjOo2EcSp7aq63z6oyvJRvYIb0JW3tC/34j+0f7jWV/j6mX0uHEfFeMGus3SZM9
	sn3J6k2gSktmfDFjhMIysMlm7vd16mD41wUXZwuWMQ7rpjsXb/4kTu5br9sS6NGFKqoWdwgUFHS
	Bas2QZOc/vyIY0ZF2awOZTA5gpdyM+2DBQqqFcDtRn0LlNCCnUwuQ2BsJZz6+Cveiz4Tvbgxfxj
	bjVPWtjRrz6O1nE58u/M7yELGMVeSiSsGA8DEGDWrsHm4Yh9YakOauMKEP/6oPTsYHlGKefvKkm
	zbLJWdB5gQcBtNzoh6mNqNoDLQKPUPc1mu8df2G9WoCRCy/IwtG+iwDGPS
X-Received: by 2002:a05:690c:d8a:b0:794:ecaf:c501 with SMTP id 00721157ae682-798dd787623mr73153487b3.46.1772966260560;
        Sun, 08 Mar 2026 03:37:40 -0700 (PDT)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com. [74.125.224.43])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee68c47sm30836087b3.43.2026.03.08.03.37.38
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 03:37:38 -0700 (PDT)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64aea64bf15so9879592d50.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 03:37:38 -0700 (PDT)
X-Received: by 2002:a05:690e:12c1:b0:646:eabb:3431 with SMTP id
 956f58d0204a3-64d1427c348mr7923915d50.47.1772966258221; Sun, 08 Mar 2026
 03:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303090253.42076-1-email@sirat.me> <20260303090253.42076-3-email@sirat.me>
 <20260307135917.398891db@jic23-huawei>
In-Reply-To: <20260307135917.398891db@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Sun, 8 Mar 2026 16:37:26 +0600
X-Gmail-Original-Message-ID: <CANn+LWL57iruSLnmg8rY5qrgnzLww+Z9hUc=ZveA31dKh9k6Fw@mail.gmail.com>
X-Gm-Features: AaiRm53CCNCmKKkEs9TJfm9Po4r_8EU_06YadRai549XIWRf18gV0JA-VsMeiHM
Message-ID: <CANn+LWL57iruSLnmg8rY5qrgnzLww+Z9hUc=ZveA31dKh9k6Fw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 7:59=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue,  3 Mar 2026 15:02:41 +0600
> Siratul Islam <email@sirat.me> wrote:
...
> Hi,
>
> Various comments inline.
>
> Pretty nice for a v1 ;)
>
> Jonathan
>
Hi! Thank you for the review!
Please find my responses below regarding the changes for v2
>
...
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
>
> Check that you have includes for all things used directly in this
> driver. For example dev_err()
>
> We use a slightly relaxed version of include what you use for IIO
> (and the kernel in general). So sometimes there are headers that
> are well documented as including others, but when that's not true
> we don't make assumptions and so include everything relevant even
> if it happens to be included via another path today.
>
I've added linux/device.h, linux/bitfield.h, linux/completion.h, and
linux/mod_devicetable.h. Hopefully this covers everything. For dev_err(),
I was conflicted between linux/dev_printk.h and linux/device.h, but
ended up using the latter.
>
...
> > +#define VL53L1X_IDENTIFICATION__MODEL_ID 0x010F
>
> Register addresses are a case where it can be helpful to use tabs
> to make the addresses all line up.
>
Done
>
> >
> > +static const struct regmap_config vl53l1x_regmap_config =3D {
> > +     .reg_bits =3D 16,
> > +     .val_bits =3D 8,
> > +     .reg_format_endian =3D REGMAP_ENDIAN_BIG,
>
> 8 bit registers don't really have an endian. This doesn't (I think)
> apply to multiregister writes.
>
Done
>
>
> > +static int vl53l1x_chip_init(struct vl53l1x_data *data)
> > +{
> > +     struct device *dev =3D &data->client->dev;
> > +     unsigned int val;
> > +     u16 model_id;
> > +     int tries =3D 200;
> > +     bool ready;
> > +     int ret;
> > +
> > +     ret =3D regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x00);
> Is this useful if we have a hardware reset? It's common to do
> hardware if possible and software only if it isn't.
>
The device is now hardware-reset via the XSHUT pin during power-on, so
chip_init only does the software reset sequence when no XSHUT GPIO is
available
>
> > +     if (ret)
> > +             return ret;
> > +     usleep_range(100, 200);
> fsleep() and ideally a spec reference in a comment for why this value.
> > +
> > +     ret =3D regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x01);
> > +     if (ret)
> > +             return ret;
> > +     usleep_range(1000, 2000);
> fsleep
>
Switched all usleep_range() to fsleep() and added comments with
why the values
>
> > +
...
> > +
> > +     if (model_id !=3D VL53L1X_MODEL_ID_VAL) {
> > +             dev_err(dev, "unknown model id: 0x%04x\n", model_id);
>
> Don't error out in this case. It breaks any possibility of a future
> backwards compatible chip being supported by this driver via a fallback
> dt compatible.  The most we do is print an informational message
> to help with debug.
>
> We do have some old drivers that we still need to fix up that are
> doing this sort of hard check on an who am I register.
>
>
> > +             return -ENODEV;
> > +     }
> ...
>
Changed to dev_info() and let probe continue.
>
> > +
> > +static int vl53l1x_set_distance_mode(struct vl53l1x_data *data,
> > +                                  enum vl53l1x_distance_mode mode)
> > +{
> > +     int ret;
> > +
> > +     switch (mode) {
> > +     case VL53L1X_SHORT:
> Can we encode all the values into a structure.  Then make this just
> a pick of the structure, followed by writing the values out.
> should end up more compact that this due to the reuse of all the regmap
> calls and error handling.
>
I refactored this using reg_sequence arrays. I also used
regmap_multi_reg_write()
as David suggested in his review below.
>
> > +             ret =3D regmap_write(data->regmap,
> > +                                VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACRO=
P,
> > +                                0x14);
...
> > +
> > +static int vl53l1x_set_timing_budget(struct vl53l1x_data *data, u16 bu=
dget_ms)
> Add some documentation as it's not obvious what this is doing.
>
Added a comment explaining the timing budget.
The pre-computed register values come from ST ULD.
>
...
> > +
> > +                     usleep_range(1000, 5000);
>
> fsleep()
>
> Also add a comment to say why this many tries with this sleep.
> Check for all other places this comment applies.
>
Done
>
...
>
> > +
> > +static int vl53l1x_validate_trigger(struct iio_dev *indio_dev,
> > +                                 struct iio_trigger *trig)
> > +{
> > +     struct vl53l1x_data *data =3D iio_priv(indio_dev);
> > +
> > +     return data->trig =3D=3D trig ? 0 : -EINVAL;
>
> Can we use the generic iio_validate_own_trigger()?
>
> Cheats a bit and relies on the parents being the same (which they
> always should be as it's one device.  Advantage
> is no need for a trig variable in data.
>
Yes! Switched to iio_validate_own_trigger()
>
...
> > +
> > +     ret =3D vl53l1x_read_u16(data,
> > +                            VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_=
RANGE_MM_SD0,
> > +                                &scan.distance);
>
> Another odd bit of alignment. Should match the line above.
>
Fixed.
>
...
> > +
> > +static irqreturn_t vl53l1x_threaded_irq(int irq, void *priv)
> > +{
> > +     struct iio_dev *indio_dev =3D priv;
> > +     struct vl53l1x_data *data =3D iio_priv(indio_dev);
> > +
> > +     if (iio_buffer_enabled(indio_dev))
> Neither of these needs to be done in a threaded hander.
> I'd make this a non threaded irq handler and mark the irq
> as IRQF_NO_THREAD as you'll then be using iio_trigger_poll()
>
> The advantage of that is it allows better timestamp gathering
> as nearer the interrupt.
>
Changed to a hardirq handler with iio_trigger_poll() and
IRQF_NO_THREAD. Also switched to devm_request_irq() since
there's no threaded part anymore.
>
...
> > +     if (!irq_flags)
> > +             irq_flags =3D IRQF_TRIGGER_FALLING;
> Leave that to firmware.  We used to do this a lot in drivers, but it
> was always the wrong approach. The snag is we can't fix drivers that do
> it now without risking regressions. However we don't want to introduce
> new ones.
>
Done. Dropped it.
>
...
> > +
> > +static void vl53l1x_power_off(void *_data)
>
> > +{
> > +     struct vl53l1x_data *data =3D _data;
> > +
> > +     vl53l1x_stop_ranging(data);
>
> This looks to be undoing something that wasn't done in power_on?
> If so probably wants to be a separate devm cleanup.
>
> Whilst it may not matter as turning things off tends to be idempotent
> it will be easier to follow the code if we only stop what we started.
>
Split into a separate devm_add_action_or_reset() for stop_ranging,
registered right after start_ranging in probe.
>
> > +     gpiod_set_value_cansleep(data->reset_gpio, 1);
>
> It's unusual to put a device into reset on power down.  Is this
> pin perhaps misnamed?
>
> If it is just a reset, we'd normally break that out as separate
> from the power control and force a reset sequence in probe.
>
It's actually the XSHUT pin, not a reset. I wanted to keep standard naming.
But that might become confusing. Renamed it to xshut_gpio and updated
the DT binding to "xshut-gpios".
>
...
> > +     gpiod_set_value_cansleep(data->reset_gpio, 0);
> > +     usleep_range(3200, 5000);
>
> fsleep() preferred.  Adds a standard amount of slack.
>
Done
>
...
> > +     if (!i2c_check_functionality(client->adapter,
> > +                                  I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> > +                                          I2C_FUNC_SMBUS_BYTE_DATA))
> Align this as:
>         if (!i2c_check_functionality(client->adapter,
>                                      I2C_FUNC_SMBUS_READ_I2C_BLOCK |
>                                      I2C_FUNC_SMBUS_BYTE_DATA))
>
> Seems like an extra tab snuck in from somewhere.
>
Fixed.
>
...
> > +             ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > +                                                   indio_dev, NULL,
> > +                                                       &vl53l1x_trigge=
r_handler,
> > +                                                       &vl53l1x_buffer=
_setup_ops);
>
> Strange alignment.
>
Fixed.
>
...
> > +static const struct i2c_device_id vl53l1x_id[] =3D { { "vl53l1x" }, { =
} };
> Format this same as
>
> static const struct i2c_device_id vl53l1x_id[] =3D {
>         { "vl53l1x" },
>         { }
> };
>
Done
>
...
> > +
> > +MODULE_AUTHOR("Siratul Islam <email@sirat.me>");
> > +MODULE_DESCRIPTION("ST VL53L1X ToF ranging sensor driver");
> > +MODULE_LICENSE("Dual BSD/GPL");
>
>

Thanks again,
Sirat
