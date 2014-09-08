Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: gyro: bmg160: only set power state if PM_RUNTIME
 is defined
Date: Mon, 8 Sep 2014 13:50:01 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F199761AE@IRSMSX105.ger.corp.intel.com>
References: <1409655759-28849-1-git-send-email-irina.tirdea@intel.com>
 <540AFA13.6010207@gmx.de>
In-Reply-To: <540AFA13.6010207@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel=
.org] On Behalf Of Hartmut Knaack
> Sent: 06 September, 2014 15:12
> To: Tirdea, Irina; Jonathan Cameron; linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen; Peter Meerwald; Srinivas Pandruvada; linux-kernel=
@vger.kernel.org
> Subject: Re: [PATCH] iio: gyro: bmg160: only set power state if PM_RUNTIM=
E is defined
>=20
> Irina Tirdea schrieb:
> > When CONFIG_PM_RUNTIME is not defined and bmg160 tries to power
> > off the device, bmg160_set_power_state will call pm_runtime_put_autosus=
pend,
> > which is not implemented (wil return -ENOSYS).
> >
> > Only call bmg160_set_power_state when CONFIG_PM_RUNTIME is defined.
> Unless there is anything more to come, what about putting the #ifdef into=
 first line inside bmg160_set_power_state() and just an
> #endif before the return 0 at the end? Saves 5 lines.

Thanks for the suggestion! Will fix it in v2.

> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---


Thanks,
Irina
