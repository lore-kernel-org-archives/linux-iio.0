Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49806 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab3IOJHF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 05:07:05 -0400
Message-ID: <523586D4.1080901@kernel.org>
Date: Sun, 15 Sep 2013 11:07:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	ian.campbell@citrix.com
Subject: Re: [PATCH/RFC v6 1/2] DT: Add documentation for gp2ap020a00f sensor
References: <1377097580-4492-1-git-send-email-j.anaszewski@samsung.com> <5214FACA.5090805@wwwdotorg.org>
In-Reply-To: <5214FACA.5090805@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/21/13 18:37, Stephen Warren wrote:
> On 08/21/2013 09:06 AM, Jacek Anaszewski wrote:
>> This patch adds device tree binding documentation
>> for the gp2ap020a00f proximity/als sensor.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
Applied to the togreg branch of iio.git
(now the driver is ready to go with it!)
