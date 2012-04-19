Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59718 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab2DSQFy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Apr 2012 12:05:54 -0400
Received: from localhost (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 9238E149
	for <linux-iio@vger.kernel.org>; Thu, 19 Apr 2012 18:04:50 +0200 (CEST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Subject: [RFC] Add frequency support in trigger core
Date: Thu, 19 Apr 2012 18:05:36 +0200
Message-Id: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi List,

A lot of driver add an extra frequency attribute to allow user to tune
triggers frequency from sysfs. This is a lot of code duplication, while most
do the exact same thing.

I added here two extra fields to struct iio_trigger, frequency and info_mask,
which might not be needed at first, but will allow us to add extra parameters
more easily.

I added as well a callback for info_mask changes in trigger_ops so that drivers
can take action when frequency has been changed by the user, but will also be 
easily extendable.

Maxime

