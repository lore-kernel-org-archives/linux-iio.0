Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.153]:44396 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPT6l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Nov 2018 14:58:41 -0500
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] Use OF API to get the driver data
Date: Fri, 16 Nov 2018 10:47:20 +0100
Message-Id: <20181116094722.1070-1-sst@poczta.fm>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series will change how the driver finds out the device data. Now it
will first try to use OF API and then, if needed, fallback to the spi framework
capabilities.

Slawomir Stepien (2):
  iio: potentiometer: mcp4131: use of_device_get_match_data()
  iio: potentiometer mcp4131: use spi_get_device_id() only when needed

 drivers/iio/potentiometer/mcp4131.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.19.1
