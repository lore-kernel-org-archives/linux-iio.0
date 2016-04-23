Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58104 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbcDWIr2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 04:47:28 -0400
In-Reply-To: <20160422192757.GA18225@homes.emlix.com>
References: <20160422192757.GA18225@homes.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Nonlinear outputs
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 23 Apr 2016 09:47:24 +0100
To: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>,
	linux-iio@vger.kernel.org
Message-ID: <DFC0A6F6-004E-4D72-824B-D7ACAA7E52E4@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 22 April 2016 20:27:57 BST, "Daniel Glöckner" <dg@emlix.com> wrote:
>Hi,
>
>currently all outputs listed in Documentation/ABI/testing/sysfs-bus-iio
>are _raw. What about f.ex. a nonlinear resistive output?
>
>Shall I mark it as processed value which implies giving it an _input
>name
>or shall I fake raw values with offset = 0 and scale = 1?
Processed but then you will need to do the conversions in the driver.  If we get
 enough other cases that can be easily described we can add ABI to allow the
 conversions in userspace.

Jonathan
>
>Best regards,
>
>  Daniel

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
