Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34058 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJHnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Nov 2018 02:43:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so4349946qkg.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Nov 2018 14:01:12 -0800 (PST)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH 0/6] staging:iio:ad2s90: Add dt support and move out of staging
Date: Fri,  9 Nov 2018 20:00:38 -0200
Message-Id: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds device tree support to ad2s90, with standard
device tree id table, adds the respective dt-binding documentation,
solves a codestyle warning and move the driver out of staging.

This patch set completes all the remaining itens listed to be done
before moving the driver out of staging, enumerated in this mail thread:
https://marc.info/?l=linux-iio&m=154028966111330&w=2, except by one
codestyle problem: "CHECK: struct mutex definition without comment". It
seems to be a commonly ignored check for mutexes of device states. If I
am wrong, please, let me know and I will be happy to send a patch to
tackle it.

Matheus Tavares (6):
  staging:iio:ad2s90: Add device tree support
  staging:iio:ad2s90: Remove spi setup that should be done via dt
  staging:iio:ad2s90: Add max frequency check at probe
  dt-bindings:iio:resolver: Add docs for ad2s90
  staging:iio:ad2s90: Add SPDX license identifier
  staging:iio:ad2s90: Move out of staging

 .../bindings/iio/resolver/ad2s90.txt          | 26 ++++++++++++++++
 drivers/iio/resolver/Kconfig                  | 10 ++++++
 drivers/iio/resolver/Makefile                 |  1 +
 drivers/{staging => }/iio/resolver/ad2s90.c   | 31 ++++++++++++-------
 drivers/staging/iio/resolver/Kconfig          | 10 ------
 drivers/staging/iio/resolver/Makefile         |  1 -
 6 files changed, 57 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 rename drivers/{staging => }/iio/resolver/ad2s90.c (81%)

-- 
2.18.0
