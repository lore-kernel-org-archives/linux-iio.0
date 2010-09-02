Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:1551 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab0IBWQb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 18:16:31 -0400
From: Andrew Chew <AChew@nvidia.com>
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"khali@linux-fr.org" <khali@linux-fr.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Date: Thu, 2 Sep 2010 15:16:20 -0700
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Message-ID: <643E69AA4436674C8F39DCC2C05F763816B85AD096@HQMAIL03.nvidia.com>
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>
 <20100902231942.21375cc0@lxorguk.ukuu.org.uk>
In-Reply-To: <20100902231942.21375cc0@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, 
> store_mode, 0);
> > +static IIO_DEVICE_ATTR(magn_x_calibscale, S_IRUGO, 
> show_calibscale, NULL, 0);
> > +static IIO_DEVICE_ATTR(magn_y_calibscale, S_IRUGO, 
> show_calibscale, NULL, 1);
> > +static IIO_DEVICE_ATTR(magn_z_calibscale, S_IRUGO, 
> show_calibscale, NULL, 2);
> > +static IIO_DEV_ATTR_MAGN_X(show_raw, AK8975_REG_HXL);
> > +static IIO_DEV_ATTR_MAGN_Y(show_raw, AK8975_REG_HYL);
> > +static IIO_DEV_ATTR_MAGN_Z(show_raw, AK8975_REG_HZL);
> 
> This seems odd as an interface as it's raw when the maths to provide
> non-raw (and thus abstract and easy for user space) data is trivial
> enough to do in kernel

IIO guys want to do normalization maths above the kernel-level magnetometer IIO layer.  This interface came before me, so I'm just following current conventions.