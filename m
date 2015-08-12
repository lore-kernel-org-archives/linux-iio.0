Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34414 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbbHLL1g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:27:36 -0400
Date: Wed, 12 Aug 2015 14:26:23 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Documentation: iio-trig-sysfs: Add missing ABI
Message-ID: <cover.1439378363.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the ABI documentation for the add_trigger and remove_trigger
attributes, found in iio-trig-sysfs.

Cristina Opriceana (2):
  Documentation: iio-trig-sysfs: Document add_trigger attribute
  Documentation: iio-trig-sysfs: Add remove_trigger attribute ABI

 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
1.9.1

