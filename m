Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9560d7a2-98b2-732d-c91a-944ae381107c@denx.de>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
 <9560d7a2-98b2-732d-c91a-944ae381107c@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 Nov 2016 21:39:23 -0200
Message-ID: <CAOMZO5C_=xNdkpcargLjysr9hkTAVAb6Hb8m5LpH62o0FQYZew@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
To: Marek Vasut <marex@denx.de>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Harald Geyer <harald@ccbib.org>, Stefan Wahren <stefan.wahren@i2se.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 14, 2016 at 4:43 PM, Marek Vasut <marex@denx.de> wrote:

>> +#define MXS_LRADC_BASE               0x80050000
>
> Just for my understanding, why is this hardware address hard-coded here?
> Shouldn't that be fetched from DT ?

Yes, this base address should be retrieved from device tree.
