Return-Path: <SRS0=GBpQ=ZO=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Alison Schofield
	<amsfield22@gmail.com>, Gregor Boirie <gregor.boirie@parrot.com>, "Sanchayan
 Maity" <maitysanchayan@gmail.com>, Ken Lin <ken.lin@advantech.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH 0/2] iio: pressure: do not rely on structure field ordering
Date: Wed, 1 Feb 2017 09:09:25 +0100
Message-ID: <1485936567-3367-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi!

These two patches are needed to fix some fallout from adding the
available attribute.

I'm sending this before getting a verification that it work from Ken Lin
in the hopes that these mails will reach other recipients swifter than my
original mail appears to do [1]. It looks like my mails are held up
somewhere, because I don't seem them in archives (yet). I don't know
what is going on with that, but as I said hopefully git send-email is
more effective???

Cheers,
peda

[1] Message-ID: <28916f18-da40-cf0a-5bfa-2c8d53a7d83c@axentia.se>

Peter Rosin (2):
  iio: pressure: mpl3115: do not rely on structure field ordering
  iio: pressure: mpl115: do not rely on structure field ordering

 drivers/iio/pressure/mpl115.c  | 1 +
 drivers/iio/pressure/mpl3115.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.1.4
