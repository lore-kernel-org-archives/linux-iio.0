Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f195.google.com ([209.85.160.195]:36798 "EHLO
	mail-yk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182AbcBEVOE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2016 16:14:04 -0500
MIME-Version: 1.0
In-Reply-To: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Fri, 5 Feb 2016 19:02:12 -0200
Message-ID: <CAKi4VALtv3+_SjRG=_gmfpH=EN6D=DJJ9W8MHiCiADn56ber+A@mail.gmail.com>
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	mwelling@ieee.org, linux@roeck-us.net, eibach@gdsys.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Daniel,

On Fri, Feb 5, 2016 at 11:17 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> +
> +static const struct i2c_device_id ads1015_id[] = {
> +       {"ads1015", 0},
> +       {}
> +};

Since this module is not 100% compatible with the hwmon version,
wouldn't it be better to use another id?

Other than that, I tested it on the MinnowBoard Max with a Drone Lure
connected and it works fine.

thanks

Lucas De Marchi
