Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42157 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab3IPSZh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 14:25:37 -0400
Received: from localhost.localdomain (cpc4-cmbg6-0-0-cust321.5-4.cable.virginmedia.com [81.107.37.66])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5879440441
	for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 19:25:31 +0100 (BST)
Message-ID: <52375B3C.8020203@kernel.org>
Date: Mon, 16 Sep 2013 20:25:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: IIO: clarification about posting patches with device tree elements.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

As I was unclear on when we needed Acks from the device tree maintainers
I posted an enquiry to devietree@vger.kernel.org.  Rob Herring kindly
replied. http://www.spinics.net/lists/devicetree/msg04669.html


In brief:

1) All device tree bindings related patches should be cc'd to
devicetree@vger.kernel.org

2) Anything new (i.e. not the same as in existing drivers)
   needs an Ack from a device tree maintainer.

3) Any changes to common bindings needs an Ack from a device tree
   maintainer.

4) Anything else 'interesting' may need an Ack.

Anyhow, please all remember to cc devicetree@vger.kernel.org for
anything DT related.

Thanks,

Jonathan
