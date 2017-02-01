Return-Path: <SRS0=GBpQ=ZO=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Sanchayan Maity
	<maitysanchayan@gmail.com>, Gregor Boirie <gregor.boirie@parrot.com>, "Alison
 Schofield" <amsfield22@gmail.com>, Ken Lin <ken.lin@advantech.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v2 0/2] iio: pressure: do not rely on structure field ordering
Date: Wed, 1 Feb 2017 21:40:55 +0100
Message-ID: <1485981657-14586-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi!

v1 -> v2 changes:

- improved commit messages
- added tested-by tag

These two patches are needed to fix some fallout from adding the
available attribute.

Jonathan, it was a bitch to rebase with that line starting with a #. Please
make sure that it stays where it should be in case you decide to fixup
anything...

Cheers,
peda

Peter Rosin (2):
  iio: pressure: mpl3115: do not rely on structure field ordering
  iio: pressure: mpl115: do not rely on structure field ordering

 drivers/iio/pressure/mpl115.c  | 1 +
 drivers/iio/pressure/mpl3115.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.1.4
