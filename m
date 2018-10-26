Return-Path: <SRS0=Wa0e=NG=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-usp@googlegroups.com
Subject: [PATCH 0/6] staging:iio:ad2s90: Add scale info and improve error handling
Date: Thu, 25 Oct 2018 21:45:06 -0300
Message-Id: <20181026004512.31012-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds scale info to ad2s90's single channel, improve
error handling in it's functions and fix a possible race condition
issue.

The goal with this patch set is to address the points discussed in the
mailing list in an effort to move ad2s90.c out of staging.

Matheus Tavares (5):
  staging:iio:ad2s90: Make read_raw return spi_read's error code
  staging:iio:ad2s90: Make probe handle spi_setup failure
  staging:iio:ad2s90: Remove always overwritten assignment
  staging:iio:ad2s90: Move device registration to the end of probe
  staging:iio:ad2s90: Check channel type at read_raw

Victor Colombo (1):
  staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
    read_raw

 drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 18 deletions(-)

-- 
2.18.0
