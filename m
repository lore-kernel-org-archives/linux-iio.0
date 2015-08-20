Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:61652 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbbHTJ5z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 05:57:55 -0400
From: =?iso-8859-1?Q?Sean_Nyekj=E6r?= <Sean.Nyekjaer@prevas.dk>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: DAC switch between current and voltage mode
Date: Thu, 20 Aug 2015 09:57:52 +0000
Message-ID: <715D9F6A60DF2F458F39683D45F6609A7E22F4FC@VMPREVAS1.prevas.se>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all

I'm in the process of creating a custom BSP with an ad5755 dac. It an requirement to be able to switch between voltage and current mode per channel from userspace.
Is it possible with the current iio interface?
Is there a feature in the pipeline where it's possible to do this switch?

Regards
Sean Nyekjær