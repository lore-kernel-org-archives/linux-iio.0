Return-Path: <SRS0=lFjb=GD=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 13 Mar 2018 13:05:06 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging:iio:ad2s1210: Rework read/write operation for
 fclkin and fexin
Message-ID: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patchset changes the way that frequency of clock input (fclkin) and
the excitation frequency (fexcit) are exposed to the userspace. The
original code uses the IIO_DEVICE_ATTR to export the configuration of
fclkin and fexcit to the userspace which is not in agreement with the
current ABI. This patchset adds one channel per clock configuration,
updating the read_raw function by adding a handler for the new channels,
and introduces the write_raw function.  Furthermore, this patchset
removes the legacy code responsible for the read and write operation
related to fclkin and fexcit. Finally, this patchset uses parts of the
original code for handling frequency configuration as an attempt to
avoid problems.

Changes in v2:
 - Removes unnecessary switch case in the write_raw function.
 - Replaces the use of goto for direct return.
 - Removes definition with string.
 - Removes unecessary label.

Rodrigo Siqueira (3):
  staging:iio:ad2s1210: Add channel for fclkin and fexcit
  staging:iio:ad2s1210: Add frequency handler in read_raw
  staging:iio:ad2s1210: Add write_raw to handle frequency

 drivers/staging/iio/resolver/ad2s1210.c | 191 +++++++++++++++-----------------
 1 file changed, 92 insertions(+), 99 deletions(-)

-- 
2.16.2
