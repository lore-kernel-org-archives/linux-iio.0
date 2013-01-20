Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42131 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3ATMyT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jan 2013 07:54:19 -0500
Message-ID: <50FBE8F8.7010300@kernel.org>
Date: Sun, 20 Jan 2013 12:54:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: STMicroelectronics drivers
References: <1358528329-2593-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358528329-2593-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/18/2013 04:58 PM, Denis CIOCCA wrote:
> Hi Jonathan, Lars,
> 
> I have modified some part of code and added it to common library, the remainder I think can not be moved.
> I have also modified the kconfig and makefile.
> 
> Thanks!
> 
> Denis
> 
Denis this still doesn't work.

I'll send you a patch to make it actually do so.

With what you sent out in this series, simply building the lot
as modules fails.

Anyhow, patches to follow.  They are not clean but the do
work, please merge them into yours or argue why the approach
used does not work...

Jonathan
