Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D086C433B4
	for <linux-iio@archiver.kernel.org>; Sun,  2 May 2021 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14B7610A2
	for <linux-iio@archiver.kernel.org>; Sun,  2 May 2021 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhEBNtp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 May 2021 09:49:45 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net ([79.137.123.219]:50751 "EHLO
        smtpout1.mo3004.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231941AbhEBNto (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 09:49:44 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.16.111])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 7F87B23CF83;
        Sun,  2 May 2021 13:48:51 +0000 (UTC)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 2 May 2021
 15:48:50 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v2 0/3] iio: sps30: add support for serial interface
Date:   Sun, 2 May 2021 15:44:28 +0200
Message-ID: <20210502134431.42647-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG4EX1.emp2.local (172.16.2.31) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 12520851389277887511
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhephedtgefgkeduvdekheeggefghffhteekleetvdekvddtveeutdetueefueehieetnecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheprhhosghhodgutheskhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One can communicate with sensor either over i2c or serial interface.
This series add support for the latter. And in order to do that existing
codebase needs to be separated into core and interface specific
components.

v2:
- simplify Kconfig by hiding core component selection
- export symbols as GPL compatible
- drop excessive ops wrappers
- rework ops to use __be32
- rework polling for measurements, sensor produces measurements within
  1s so instead of polling just wait 1s
- simplify frame ready condition (serial)
- don't mix char with unsigned version
- calculate checksum during frame validation (serial)
- uncomment return status in frame validation (serial)
- pass part name to probe instead of KBUILD_MODNAME

Tomasz Duszynski (3):
  iio: sps30: separate core and interface specific code
  iio: sps30: add support for serial interface
  dt-bindings: iio: chemical: sps30: update binding with serial example

 .../iio/chemical/sensirion,sps30.yaml         |   7 +-
 MAINTAINERS                                   |   2 +
 drivers/iio/chemical/Kconfig                  |  27 +-
 drivers/iio/chemical/Makefile                 |   2 +
 drivers/iio/chemical/sps30.c                  | 269 ++---------
 drivers/iio/chemical/sps30.h                  |  35 ++
 drivers/iio/chemical/sps30_i2c.c              | 251 ++++++++++
 drivers/iio/chemical/sps30_serial.c           | 428 ++++++++++++++++++
 8 files changed, 794 insertions(+), 227 deletions(-)
 create mode 100644 drivers/iio/chemical/sps30.h
 create mode 100644 drivers/iio/chemical/sps30_i2c.c
 create mode 100644 drivers/iio/chemical/sps30_serial.c

--
2.31.1

