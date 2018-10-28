Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeJ2DsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:48:00 -0400
Date: Sun, 28 Oct 2018 19:02:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, khilman@baylibre.com,
        carlo@caione.org
Subject: Re: [PATCH 2/7] iio: adc: meson-saradc: add support for the chip's
 temperature sensor
Message-ID: <20181028190223.35fb8f49@archlinux>
In-Reply-To: <CAFBinCAy_1R01RH=JcT6Fhf_ScDvZ2g3cYdaT-s=VsVQGN+LNg@mail.gmail.com>
References: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
        <20181028122629.10144-3-martin.blumenstingl@googlemail.com>
        <20181028163506.4305f0b8@archlinux>
        <CAFBinCAy_1R01RH=JcT6Fhf_ScDvZ2g3cYdaT-s=VsVQGN+LNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Oct 2018 18:02:28 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

Hi Martin,
..

> > > +     if (buf[3] & MESON_SARADC_EFUSE_BYTE3_IS_CALIBRATED)
> > > +             priv->temperature_sensor_calibrated = true;
> > > +     else
> > > +             priv->temperature_sensor_calibrated = false;  
> >
> > Could just assign?
> >         priv->temperature_sensor_calibrated =
> >                 buf[3] & MEESON_SARADC_EFUSE_BYTE3_IS_CALIBRATED;  
> I could change this but (personal preference here) my eyes are not
> trained to read variable assignments where the value is broken into a
> new line
> looking back at it I could also remove the whole "else" block as
> "false" is obviously the default value
> 
> let me know whether you'd like me to change this, then I'll do that for v2

I don't feel strongly on any of the options.. Take your pick!

> 
> > > +
> > > +     priv->temperature_sensor_coefficient = buf[2] & trimming_mask;
> > > +
> > > +     upper_adc_val = FIELD_GET(MESON_SARADC_EFUSE_BYTE3_UPPER_ADC_VAL,
> > > +                               buf[3]);
> > > +
> > > +     priv->temperature_sensor_adc_val = buf[2];
> > > +     priv->temperature_sensor_adc_val |= upper_adc_val << BITS_PER_BYTE;
> > > +     priv->temperature_sensor_adc_val >>= trimming_bits;
> > > +
> > > +     kfree(buf);
> > > +
> > > +     return 0;
> > > +}
> > > +  
> > ...  
> 
> 
> Regards
> Martin
