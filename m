Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52606 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2GPI0Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jul 2012 04:26:25 -0400
Received: from [192.168.27.111] (unknown [81.138.163.57])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2B6A14026C
	for <linux-iio@vger.kernel.org>; Mon, 16 Jul 2012 09:26:22 +0100 (BST)
Message-ID: <5003D02D.10601@kernel.org>
Date: Mon, 16 Jul 2012 09:26:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio <linux-iio@vger.kernel.org>
Subject: IIO 3.6 merge window now closed.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

As Linus has pretty much said he won't do another release
candidate, the 3.6 merge window will open in approximately
1 week. For IIO I'm copying Greg's policy with staging
(for obvious reasons ;) and closing our merge window now.
Rather tediously this means cutting a few of my own patches
off. Oh well got to be fair about things and I'll have those
queued up for 3.7 nice and early!

Obviously fixes can still get queued up for 3.6, but will probably
not go upstream until after 3.6-rc1.  As ever, please make
sure that fixes are entirely separate from improvements
/ feature enhancements / new drivers.

Jonathan
