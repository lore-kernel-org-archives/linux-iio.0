Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f174.google.com ([209.85.160.174]:33386 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJ0Kjz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Oct 2018 06:39:55 -0400
Received: by mail-qt1-f174.google.com with SMTP id i15-v6so3439456qtr.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Oct 2018 19:00:35 -0700 (PDT)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/6] staging:iio:ad2s90: Add scale info and improve error handling
Date: Fri, 26 Oct 2018 22:59:59 -0300
Message-Id: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds scale info to ad2s90's single channel, improve
error handling in it's functions and fix a possible race condition
issue.

The goal with this patch set is to address the points discussed in the
mailing list in an effort to move ad2s90.c out of staging.

Changes in v2:
 - Added my S-o-B in patch 5.

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
