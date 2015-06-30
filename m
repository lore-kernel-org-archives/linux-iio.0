Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:56341 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbbF3L23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 30 Jun 2015 07:28:29 -0400
From: Martin Kepplinger <martink@posteo.de>
To: pmeerw@pmeerw.net, jic23@kernel.org
Cc: christoph.muellner@theobroma-systems.com,
	martin.kepplinger@theobroma-systems.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: mma8452: add support for 3 more devices
Date: Tue, 30 Jun 2015 13:26:40 +0200
Message-Id: <1435663602-29868-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first patch doesn't change anything for existing users of mma8452. Please
test this if you can!

The second patch corrects how interrupts are described as IIO events. It exists
seperately because it changes the driver's behaviour for existing users of
mma8452.

