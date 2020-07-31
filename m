Return-Path: <SRS0=nmJT=BK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1ACC433E1
	for <linux-iio@archiver.kernel.org>; Fri, 31 Jul 2020 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7AC2067D
	for <linux-iio@archiver.kernel.org>; Fri, 31 Jul 2020 07:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgGaHCL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:02:11 -0400
Received: from mailout10.rmx.de ([94.199.88.75]:51475 "EHLO mailout10.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbgGaHCK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 31 Jul 2020 03:02:10 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout10.rmx.de (Postfix) with ESMTPS id 4BHyrb3XV4z36mZ;
        Fri, 31 Jul 2020 09:02:07 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BHyrD4GQkz2xwy;
        Fri, 31 Jul 2020 09:01:48 +0200 (CEST)
Received: from N95HX1G2.localdomain (192.168.54.61) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 31 Jul
 2020 09:01:23 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Eggers" <ceggers@arri.de>
Subject: [PATCH v4 0/2] iio: light: Support AMS AS73211 digital XYZ sensor
Date:   Fri, 31 Jul 2020 09:01:12 +0200
Message-ID: <20200731070114.40471-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.61]
X-RMX-ID: 20200731-090152-4BHyrD4GQkz2xwy-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

his series adds support for the AMS AS73211 digital XYZ sensor.

Changes in v4:
---------------
- Integrated 2nd review from Andy Shevchenko
- Use more devm_ functions in as73211_probe()

Changes in v3:
---------------
- Integrated comments from Andy Shevchenko
- Integrated comments from Jonathan Cameron

Changes in v2:
---------------
- Fix $id in dt binding
- Document full I2C address range in "reg" property
- Move "buffer" member out of "struct as73211_data"
- Fix sparse warnings by using correct data types



