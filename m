Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35955 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbcEDOk5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:40:57 -0400
Received: from localhost.localdomain (unknown [82.98.7.203])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id F36834309D
	for <linux-iio@vger.kernel.org>; Wed,  4 May 2016 15:40:55 +0100 (BST)
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [RFC] Make the devm_iio_device_alloc call set iio_dev.dev.parent.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f71d4bfe-fd29-7f00-d770-f62221118000@kernel.org>
Date: Wed, 4 May 2016 11:56:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

One thing that I discovered via a recent input device review is that
the equivalent of our devm_iio_device_alloc there also sets the
dev.parent.

Should we do the same in IIO?

I'm a bit in too minds as it feels like it is only sort of 'part of the
allocation'.

Still it drops one line from nearly every IIO driver.
Could do the same for dev_iio_trigger_alloc as well I guess for double
savings.

Anyhow, a little cleanup that seemed like a moderately good idea to
me so I thought I'd see what the general view was.

Jonathan
