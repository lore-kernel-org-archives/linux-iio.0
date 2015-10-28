Return-Path: <nicola@corna.info>
Mime-Version: 1.0
Date: Wed, 28 Oct 2015 06:46:28 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH v3 4/4] iio: humidity: si7020: added No Hold read mode
To: "Wolfram Sang" <wsa@the-dreams.de>
Cc: "Stephen Warren" <swarren@wwwdotorg.org>, "Lee Jones"
 <lee@kernel.org>, "Eric Anholt" <eric@anholt.net>, "Jonathan Cameron"
 <jic23@kernel.org>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Hartmut Knaack" <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Peter Meerwald"
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
In-Reply-To: <20151027233000.GB1572@katana>
References: <20151027233000.GB1572@katana>
 <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-4-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

October 28 2015 12:30 AM, "Wolfram Sang" <wsa@the-dreams.de> wrote:=0A> N=
ot a complete review, I just stumbled over this one:=0A> =0A>> + if (clie=
nt->adapter->quirks &&=0A>> + client->adapter->quirks->flags |=0A> =0A> '=
|' should be '&', or?=0A> =0AYes, sorry. I'll update the patch.=0A=0ANico=
la Corna=0A>> + I2C_AQ_NO_CLK_STRETCH)=0A>> + return -ENODEV;
