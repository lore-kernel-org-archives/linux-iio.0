Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33673 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbcBDMv1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2016 07:51:27 -0500
MIME-Version: 1.0
In-Reply-To: <20160203181919.GD25464@deathstar>
References: <1454518796-10897-1-git-send-email-daniel.baluta@intel.com>
	<20160203181919.GD25464@deathstar>
Date: Thu, 4 Feb 2016 14:51:26 +0200
Message-ID: <CAEnQRZDOPYDVUUXBXc7OEmAo0QEryg0PvMLXUxA__Rxu8bS=0g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Michael Welling <mwelling@ieee.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux@roeck-us.net, eibach@gdsys.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Would it be more consistent to handle the mutex outside of the switch above similar
> to how it is handled in ads1015_write_raw?
>
> Also the ads1015_set_power_state(data, false) is called either way so why not just
> use one call?
>

I don't have a strong preference for that. I think across IIO drivers
we can find both coding practices.

Indeed consistency with ads1015_write_raw is a good argument. Will fix it.

I will leave the code here for one more day and then send an updated version.

thanks,
Daniel.
