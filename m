Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47104 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3JLKu6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:50:58 -0400
Message-ID: <525937C1.6060106@kernel.org>
Date: Sat, 12 Oct 2013 12:51:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 16/20] iio: Add a hysteresis event info attribute
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-16-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
> For some devices it is possible to configure a hysteresis for threshold (or
> similar) events. This patch adds a new hysteresis event info type which allows
> for easy creation and read/write handling of the sysfs attribute.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied, thanks.
