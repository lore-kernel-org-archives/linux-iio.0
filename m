Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6c866a82-8f54-575e-0376-fc9653078b7c@kernel.org>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
 <1467251334-30594-11-git-send-email-linus.walleij@linaro.org> <6c866a82-8f54-575e-0376-fc9653078b7c@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Jul 2016 15:37:22 +0200
Message-ID: <CACRpkdbwh4dzFMeQq2R3TF-Grvh6GqCMaK9v640dEYFBeAnzSg@mail.gmail.com>
Subject: Re: [PATCH 10/10 v4] iio: pressure: bmp280: read calibration data once
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>, Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>, Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 3, 2016 at 12:23 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 30/06/16 02:48, Linus Walleij wrote:
>> The calibration data is described as coming from an E2PROM and that
>> means it does not change. Just read it once at probe time and store
>> it in the device state container. Also toss the calibration data
>> into the entropy pool since it is device unique.
>>
>> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Applied with a whole 1 line of fuzz ;)

Thanks for applying and fixing my silly mistakes along the road.

Part of the churn comes from massaging review comments into
the patch set, I guess I just need to be more careful to build at
every step along the way when doing that.

But the patch splitting up the driver was driving me nuts with
the constant rebasing and drew a lot of focus, I blame it all on
that one.

Mostly the splitting and adding SPI interface was about obsoleting
the misc driver so it's for a higher cause....

Yours,
Linus Walleij
