Return-Path: <SRS0=qdDs=NF=gmail.com=renatogeh@kernel.org>
Date: Thu, 25 Oct 2018 19:29:31 -0300
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	alexandru.Ardelean@analog.com, stefan.popa@analog.com,
	giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] staging: iio: ad7780: correct driver read
Message-ID: <cover.1540506298.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

The purpose of this series is to correct two issues in the driver's raw
read function.

Changelog:
* v2
	- separated original patch into two patches
	  (https://marc.info/?l=linux-iio&m=154047435605492)

Renato Lui Geh (2):
  staging: iio: ad7780: update voltage on read
  staging: iio: ad7780: fix offset read value

 drivers/staging/iio/adc/ad7780.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.19.1
