Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD9C282E1
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6E120857
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 08:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555923066;
	bh=uoIPXQZ39aqXDfcwgrnP434WXGGy7qcxx/EjBzIHMrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=j9+pyfHamYGOkP+Vp8FSgMs9/GmUY36jB7MryF64NBQbS9zjnHW1zlMmxagvuKgB+
	 yfNJMiqW/pcMd1EjGOkD4vBvN9Cg/CDxRCqOYlYNpSJ9UMQbqetwl4OQAJai+xkAQS
	 oO6FAe/KGon8GCBeExc8bs+2ja1WzOHzy3iJRlVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDVIvG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDVIvG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Apr 2019 04:51:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865E720857;
        Mon, 22 Apr 2019 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555923064;
        bh=uoIPXQZ39aqXDfcwgrnP434WXGGy7qcxx/EjBzIHMrE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgGcRHSRxrfBwDTqvpLDcKIZFHEYEyxBxhDFQFclEMkKfZMIkWCgKqgIOfa3KbmQn
         whSyreDQtbSq6qm8wqQ7BaCVmkefKyMgifP5G2XPFFq3t/yZzSQoZx/f4UferBOqBT
         3APnmoJWXLjvnxyxPLgVOoO7Jq2ZXjj9gxZXgJ7k=
Date:   Mon, 22 Apr 2019 09:51:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "Song, Hongyan" <hongyan.song@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: Add more data field for iio driver
 hysteresis parsing
Message-ID: <20190422095100.59ce99af@archlinux>
In-Reply-To: <d5085421bb3305d896930192b99c5bf84260e5c1.camel@intel.com>
References: <1554773465-21882-1-git-send-email-hongyan.song@intel.com>
        <20190414133615.56be4eb1@archlinux>
        <d5085421bb3305d896930192b99c5bf84260e5c1.camel@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Apr 2019 01:29:28 +0000
"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> wrote:

> On Sun, 2019-04-14 at 13:36 +0100, Jonathan Cameron wrote:
> > On Tue,  9 Apr 2019 09:31:04 +0800
> > hongyan.song@intel.com wrote:
> >   
> > > From: Song Hongyan <hongyan.song@intel.com>
> > > 
> > > Add more data field support for als, incli_3d, rotation, press
> > > hysteresis parsing. In some implementation may uses them as
> > > sensitivity
> > > modifier, without this change hysteresis may not be able to read
> > > and
> > > write.
> > > 
> > > Signed-off-by: Song Hongyan <hongyan.song@intel.com>  
> > 
> > Thanks for the patch. I'll be honest I'm lost in these descriptors
> > sometimes!
> > 
> > Srinivas, could you give some input on this one?  
> I don't see we have defined hysteresis attribute in
> "Documentation/ABI/testing/sysfs-bus-iio" for non events.
> The current hysteresis is taken a absolute raw value in relation to the
> other axes in the same unit.
> 
> But it is better if we add different hysteresis attributes for non
> absolute hysteresis.
> 
> For example
> in_xxx_hysteresis_pct_range for "Modifier: Change Sensitivity Percent
> of Range" usage id: 310
> in_xxx_hysteresis_pct_relative for "Modifier: Change Sensitivity
> Percent Relative" usage id: 311

Hmm. This is indeed a corner we don't often hit.  Basically we are looking
at a 'dead zone'.  For most IIO devices we don't do this as it is
removing information some usecases might want.  If people want to
do this on sensors, it's normally done using a motion detect type
event and then reading the sensor value to find out what the motion
was.

I'm not sure hysteresis is the right term to use here though.
We aren't dealing with offsets in a threshold depending on direction,
but rather at minimum change before reporting from the previous value
(in either direction).  Mind you I'm not quite sure what the right
term would be!  It may be that sensitivity is the term to use. In
some ways this is very like reducing the bit depth of the sensor,
which is what that term brings to mind for me.

Thanks,

Jonathan

> 
> 
> Thanks,
> Srinivas
> 
> 
> 
> > 
> > I will note however, that from a quick look we tend to air these
> > queries with dev_dbg entries.  We should be consistent with these new
> > ones
> > as well.attaributes
> > 
> > Thanks,
> > 
> > Jonathan  
> > > ---
> > >  drivers/iio/light/hid-sensor-als.c            | 8 ++++++++
> > >  drivers/iio/orientation/hid-sensor-incl-3d.c  | 8 ++++++++
> > >  drivers/iio/orientation/hid-sensor-rotation.c | 7 +++++++
> > >  drivers/iio/pressure/hid-sensor-press.c       | 8 ++++++++
> > >  include/linux/hid-sensor-ids.h                | 1 +
> > >  5 files changed, 32 insertions(+)attaributes
> > > 
> > > diff --git a/drivers/iio/light/hid-sensor-als.c
> > > b/drivers/iio/light/hid-sensor-als.c
> > > index 94f3325..bb19178 100644
> > > --- a/drivers/iio/light/hid-sensor-als.c
> > > +++ b/drivers/iio/light/hid-sensor-als.c
> > > @@ -271,6 +271,14 @@ static int als_parse_report(struct
> > > platform_device *pdev,
> > >  			st->common_attributes.sensitivity.index,
> > >  			st->common_attributes.sensitivity.report_id);
> > >  	}
> > > +	if (st->common_attributes.sensitivity.index < 0) {
> > > +		sensor_hub_input_get_attribute_info(hsdev,
> > > +			HID_FEATURE_REPORT, usage_id,
> > > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_RE
> > > L_PCT |
> > > +			HID_USAGE_SENSOR_LIGHT_ILLUM,
> > > +			&st->common_attributes.sensitivity);
> > > +	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > index bdc5e45..7da1e3f 100644
> > > --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > @@ -305,6 +305,14 @@ static int incl_3d_parse_report(struct
> > > platform_device *pdev,
> > >  			st->commpcton_attributes.sensitivity.index,
> > >  			st->common_attributes.sensitivity.report_id);
> > >  	}
> > > +	if (st->common_attributes.sensitivity.index < 0) {
> > > +		sensor_hub_input_get_attribute_info(hsdev,
> > > +			HID_FEATURE_REPORT, usage_id,
> > > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > > S |
> > > +			HID_USAGE_SENSOR_ORIENT_TILT,
> > > +			&st->common_attributes.sensitivity);
> > > +	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> > > b/drivers/iio/orientation/hid-sensor-rotation.c
> > > index a69db20..201e320 100644
> > > --- a/drivers/iio/orientation/hid-sensor-rotation.c
> > > +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> > > @@ -229,6 +229,13 @@ static int dev_rot_parse_report(struct
> > > platform_device *pdev,
> > >  			st->common_attributes.sensitivity.index,
> > >  			st->common_attributes.sensitivity.report_id);
> > >  	}
> > > +	if (st->common_attributes.sensitivity.index < 0) {
> > > +		sensor_hub_input_get_attribute_info(hsdev,
> > > +			HID_FEATURE_REPORT, usage_id,
> > > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > > S |
> > > +			HID_USAGE_SENSOR_ORIENT_QUATERNION,
> > > +			&st->common_attributes.sensitivity);
> > > +	}
> > >  
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/iio/pressure/hid-sensor-press.c
> > > b/drivers/iio/pressure/hid-sensor-press.c
> > > index d7b1c00..bf5d2ac 10064pct4
> > > --- a/drivers/iio/pressure/hid-sensor-press.c
> > > +++ b/drivers/iio/pressure/hid-sensor-press.c
> > > @@ -250,6 +250,14 @@ static int press_parse_report(struct
> > > platform_device *pdev,
> > >  			st->common_attributes.sensitivity.index,
> > >  			st->common_attributes.sensitivity.report_id);
> > >  	}
> > > +	if (st->common_attributes.sensitivity.index < 0) {
> > > +		sensor_hub_input_get_attribute_info(hsdev,
> > > +			HID_FEATURE_REPORT, usage_id,
> > > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > > S |
> > > +			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE,
> > > +			&st->common_attributes.sensitivity);
> > > +	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> > > sensor-ids.h
> > > index 76033e0..a875b9be 100644
> > > --- a/include/linux/hid-sensor-ids.h
> > > +++ b/include/linux/hid-sensor-ids.h
> > > @@ -158,6 +158,7 @@
> > >  /* Per data field properties */
> > >  #define HID_USAGE_SENSOR_DATA_MOD_NONE				
> > > 	0x00
> > >  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		
> > > 0x1000
> > > +#define
> > > HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE
> > > 000
> > >  
> > >  /* Power state enumerations */
> > >  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x20085
> > > 0  
> > 
> >   

