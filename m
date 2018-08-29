Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f177.google.com ([209.85.215.177]:40816 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2VdI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Aug 2018 17:33:08 -0400
Received: by mail-pg1-f177.google.com with SMTP id z25-v6so2629865pgu.7
        for <linux-iio@vger.kernel.org>; Wed, 29 Aug 2018 10:35:11 -0700 (PDT)
Received: from [192.168.1.68] (d50-92-226-185.bchsia.telus.net. [50.92.226.185])
        by smtp.gmail.com with ESMTPSA id l9-v6sm6511537pgg.79.2018.08.29.10.35.08
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 10:35:08 -0700 (PDT)
To: linux-iio <linux-iio@vger.kernel.org>
From: David Frey <dpfrey@gmail.com>
Subject: Idea: regmap_config.use_single_rw -> use_single_read,
 use_single_write
Message-ID: <2992280e-55f0-00d6-24cd-30714891ddc9@gmail.com>
Date: Wed, 29 Aug 2018 10:35:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I just want to float an idea and see if it gets any support.

In struct regmap_config, there is a member "bool use_single_rw" which is
documented as follows:

"If set, converts the bulk read and write operations into a series of
single read and write operations. This is useful for device that does
not support bulk read and write."

My idea is to split this into:
	bool use_single_read;
	bool use_single_write;

I think this would be useful because at least one device that I'm using
(Bosch bmi160 IMU) supports bulk reads, but not bulk writes.  It would
be convenient to be able to use regmap_bulk_read and regmap_bulk_write
and have only regmap_bulk_write split the writes apart.  This change
would also support the case where a device supports bulk writes, but not
bulk reads.  I don't know of such a device, but I haven't made any
attempt to find one.

What do you think?

David Frey
