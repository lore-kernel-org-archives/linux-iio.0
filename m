Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4E4028E2
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763872; cv=none; b=CDz2L8SJfkbemMXKjvC8fHRa/c1jm/9CTkqCTrUxL9eRq67NzftXvP17i/z+/9Aa3lB1Y9tXFYfTIqRZlJGXB4pY7K8KoePvgx0ZfL4GQvyWZYgOJRrnuFC8IGiqDpwIr7ha0bxuvZLRNcJXKjuU0pyrK55wlYAJUDBxa2M13rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763872; c=relaxed/simple;
	bh=7fo7r52nEPlzNK+NJp+U1AWQPC7MthGN29osZqvPtBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjC81zv0h912LNznmBGVQ+zGBkztAJCS47i1l4zJ7ioypwjdqMUfliNatOGy11d1mD7SxLW9MmxiOk0bS4GnUl2swG333y2zNbXa1Ecd6aV36pr/TrWCbrIzSmKMNfx+j6hJ4EygwNDHsDpXaz77Kz45eyrd8zmBnoXdBBdl1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8Bk2JHo; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8Bk2JHo"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c9995ca60so3981663d50.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763869; x=1789368669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6FgqnX2MNX4iTAsFR2V7ICidK9phwa3U3RsTiO1qRY=;
        b=T8Bk2JHov1vdndWzDrszRgThM1JS5cJaHr37Sy3rKrJioqrWXX3JTUgvtuZ+SPZPxq
         eLf5UCSDQ08w1DCWzHStREYDbBV+XiqXfWd9/MOc+R4rIUlv1tz7b6sgEzCEjeYKD9s4
         nXDwhzXO1GtNXCx/yk4rsHw94+QMcJrkdJkJieKsbuztQTxTqiXMJ1iFqK8WOVht3Z9A
         t66Ovdoxb9BqJ97aUYFtBXUf1TKEYQLMmlccKN5hJQKQt1L7OMVZSnNWcJujDzESJUaj
         Eju8SGqSm9VTC8HtPNDovdQ6GCHVYNkjqc7dHKBQtZG8G/UN0h7Fr4AEXAsXqgeQz8lX
         JJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763869; x=1789368669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6FgqnX2MNX4iTAsFR2V7ICidK9phwa3U3RsTiO1qRY=;
        b=sau8kdOOor5KoCHY+UUCuS79VeTgQ11jbkDMQi8Q2/qyxVzlVcGqrYeTgWta2FGPjp
         jc64wSL5h8boTcac4ceWyY3lN8Xtnd0vshoYzqlo+Cc+DLDYJlAHb8lzsSi7rAe7R6kr
         IJo2M4dz1xjJkl5uxtqQG5bTQeK59ID0wkCe+rMkCA4pGN6xgezegBEBTr0yjP8zXWwT
         bk6KL3A752LLlD9JojBAPUZmKFEJsklzMIKWgTn/1pbzpNs19sciKYnB8PdIh34VvT2P
         fRJPkrOtAPI5yGHRHAnkPpj6uAyh1Lx89Z6xiYLnTllLJiHPRmOPLWqaEqWedTsxymBB
         9U8A==
X-Forwarded-Encrypted: i=1; AKwUvBzeRdEglpHLnAK8C4J8YvZikZ2d2UHrpjeTsJ/8LlHgQeNidfrdBZrDPbjauhkVf0jr28KhOdTnm+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++ldIr15gkpapRg9CPEBZNKhhCq5svRYjZLWaN6IDVdOpO7+bEns
	sWORXj9m8QNayTmSuvw+juJ1XAOnFFBLHVc+cEZgreg2me5evMZGpaee
X-Gm-Gg: AYBFou1dNbW0tRaul504MeOQ1MaaEOJVE4sQ3AVoV3JeOsCV0OdIjIeu3lgzKXtBMxD
	d4KxO9EGD00P91HOFEhh1sX98FSvCFEabn2mvnSm5gg4M20w4Yd8MA0bqR/dLhFC1G8OLpJpsRI
	EWidN8FI7ryUg9+xElrdALiIIhCOE/v9NnWamRZ840l9uLqz5Z96U/vps1AFO4xSjlT9NBdj9qn
	Kjuzqcan+dFbggiJVdUGd/YGP2SYl3LJodZeZRE7sDdzsfiAKBqldLkVBCOJVADeyp5AntaKRzK
	tZR21ns5tgmFMWOQ5BO7tGQO6CQsViqZN87+GNEd09VGbdA1JTm4trkMg5SUQeZaj4PMM22WMub
	GtMYtUwGY1acPbmt0+3Rrhx666G3dYAfhLPS2j1ynXUucV9848z3z0Nag/yBxAG8dEphUcF6oFQ
	2MmFoDIhewHM7t2tVKHwdLvZJCfAqpKDgS68ChOVnmtGWG
X-Received: by 2002:a05:690e:191e:b0:66f:b0f7:5958 with SMTP id 956f58d0204a3-66fb6cb6334mr3919965d50.6.1788763869501;
        Sun, 06 Sep 2026 23:51:09 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb7c7e8d7sm6845562d50.14.2026.09.06.23.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:51:08 -0700 (PDT)
Date: Sun, 6 Sep 2026 23:51:05 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add AS7343 multi-spectral sensor driver
Message-ID: <ap5e2c1g4dJFh2yJ@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
 <521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
 <178865463956.3402141.11085158208427972814.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178865463956.3402141.11085158208427972814.b4-review@b4>

Hi Jonathan,

Thanks for the thorough review. Just some clarifying comments in line. I
should be able to send v2 over within a few business days.

On Sun, Sep 06, 2026 at 01:30:39AM +0100, Jonathan Cameron wrote:
> > This patch adds a driver for the AMS AS7343 14-channel multi-spectral
> > sensor with I2C interface.
> > 
> > The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
> > via the IIO sysfs interface. Each channel's raw data is provided as a
> > 16-bit little-endian unsigned integer.
> > 
> > Basic power management (suspend/resume) is supported. More complex
> > features such as interrupt support and configurable gain/integration
> > time will be added in future patches.
> > 
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> Hi Chang Yu,
> 
> I've avoided too much duplication with Joshua's already pretty
> thorough review so just a few additional comments inline.
> 
> 
> > diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
> > new file mode 100644
> > index 000000000000..b620dd308380
> > --- /dev/null
> > +++ b/drivers/iio/light/as7343.c
> 
> ...
> 
> > +/* AS7343 register bit masks */
> > +#define AS7343_ENABLE_PON BIT(0)
> > +#define AS7343_ENABLE_SP_EN BIT(1)
> > +#define AS7343_CFG0_REG_BANK BIT(4)
> > +#define AS7343_CFG20_AUTO_SMUX GENMASK(6, 5)
> > +#define AS7343_CONTROL_SW_RESET BIT(3)
> > +#define AS7343_CFG1_AGAIN GENMASK(4, 0)
> > +
> > +/* AS7343 settings */
> > +#define AS7343_INT_TIME 29 /* (29 + 1) * 2.87ms = 83.4ms */
> 
> Implement this as a function to do the maths and take the input in
> usecs.  Then you can call that with 83400 as the parameter to set the
> default value.  Why this default?
> 
Annoyingly for this sensor the integration time is calculated from two
registers: (ATIME + 1) * (ASTEP + 1) * 2.78us. For simplicity, I'll use
define for these two values in v2 instead of a math function.

I'll adjust the default values. The defaults in v1 are just some random
values chosen by me. In v2 I'll change them to the official recommended
values in the datasheet (x256 gain and 50.1ms integration time). These
are also the values used by adafruit in their arduino driver.
(https://github.com/adafruit/Adafruit_AS7343/blob/main/Adafruit_AS7343.cpp)

> 
> ...
> 
> > +static const struct regmap_config as7343_regmap_config = {
> > +	.name = "as7343",
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = AS7343_REG_MAX,
> > +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> > +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> > +	.cache_type = REGCACHE_NONE,
> 
> It is a big enough register map that it may make sense to use
> regcache and provide all the info on what is volatile etc.
> 

I'm debating whether this is worth it or not. All data registers
are volatile. Plus ENABLE because we need power management.
Potentially ASTEP, ATIME, CFG1 as well if we want configurable
gain/integration test in the future. That leaves us with may be
1 or 2 registers in the mapping that are not volatile. I'm leaning
towards leaving this as REGCACHE_NONE for now. Let me know what you
think.

> -- 
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Best,
Chang
