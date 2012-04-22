Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47478 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2DVRYU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 13:24:20 -0400
Message-ID: <4F943EC2.7030707@kernel.org>
Date: Sun, 22 Apr 2012 18:24:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: IIO: necessity of manual reset attribute in drivers?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

I vaguely recall asking this in response to certain drivers over the
years, but what is the usecase for userspace 'resetting' a device via
a reset attribute?  It's reasonably common in the drivers but not
(as I've kept it out) in the abi docs.

It is common in some of Analog's inertial sensor drivers but I think
turns up in various other places.

Jonathan
