Return-Path: <SRS0=UmI9=HK=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Sat, 21 Apr 2018 08:54:45 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Syne <john3909@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] stagging:iio:meter: Add essential IIO API structures for
 ADE7854
Message-ID: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patchset aims to update ADE7854 by adding the required IIO API
components. The first patch adds the iio_chan_spec for handling seven
different registers (all of them with a similar behavior). The second
patch appends the read_raw function defined by the IIO API. Finally, the
third patch adds the write_raw function and remove the attributes used
for handling the seven registers. This patchset has the contribution of
John Syne, which was responsible for mapping the correct ABI name per
element in the ADE7854; additionally, John provided codes that helped to
shape these patches.

Rodrigo Siqueira (3):
  stagging:iio:meter: Add iio_chan_spec
  stagging:iio:meter: Add ade7854_read_raw function
  stagging:iio:meter: Add ade7854_write_raw function

 drivers/staging/iio/meter/ade7854.c | 129 ++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 35 deletions(-)

-- 
2.17.0
