Return-Path: <SRS0=WEQd=NC=gmail.com=victorcolombo@kernel.org>
Date: Mon, 22 Oct 2018 17:39:34 -0300
From: Victor Colombo <victorcolombo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/2] staging: iio: ad5933: Remove unnecessary spaces
Message-ID: <20181022203934.6t525whwpp7rv47k@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl warnings:

WARNING: Blank lines aren't necessary before a close brace '}'
WARNING: No space is necessary after a cast

Victor Colombo (2):
  staging: iio: ad5933: Remove unnecessary space on casting
  staging: iio: ad5933: Remove unnecessary blank line

 drivers/staging/iio/impedance-analyzer/ad5933.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.19.1
