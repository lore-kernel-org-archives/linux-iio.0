Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0099.outbound.protection.outlook.com ([157.56.111.99]:35947
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753715AbbICJ7a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Sep 2015 05:59:30 -0400
From: Chee Nouk Phoo <cnphoon@altera.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<cnphoon.linux@gmail.com>, <cnphoon@altera.com>
Subject: [[PATCH v2] 0/2] Add Altera Modular ADC Driver
Date: Tue, 1 Sep 2015 14:49:57 -0700
Message-ID: <1441144199-20231-1-git-send-email-cnphoon@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Chee Nouk Phoon <cnphoon@altera.com>

This is 2nd version of the patch set to add support for Altera Modular ADC and
Altera Modular Dual ADC in MAX10 device family. This patch combines two separate
patches of driver and device tree binding. 

v1->v2 changes:
- update compatibility string
- update macros naming
- remove Nios2 arch dependency
- using snprintf instead of sprintf
- improve error handing
- parse resource using reg-name instead of index
- use _relaxed version of writel and readl
- remove uncessary private data

History:
--------
[v1]https://lkml.org/lkml/2015/8/27/32
    https://lkml.org/lkml/2015/8/20/227

Chee Nouk Phoon (2):
  Altera Modular ADC driver device binding
  Altera Modular ADC driver support

