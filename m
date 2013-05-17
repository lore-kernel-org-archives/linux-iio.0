Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-185.synserver.de ([212.40.185.185]:1141 "EHLO
	smtp-out-185.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab3EQMw7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2013 08:52:59 -0400
Message-ID: <5196280C.8070909@metafoo.de>
Date: Fri, 17 May 2013 14:52:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: Use buffer without trigger
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com> <2076388.y5Y0d24KYt@ctocwl0124> <519614CA.5040702@metafoo.de> <2527914.pxyfU9jjLA@ctocwl0124>
In-Reply-To: <2527914.pxyfU9jjLA@ctocwl0124>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/17/2013 02:34 PM, Denis CIOCCA wrote:
>> Yes, but you still have to assign the trigger to the device in sysfs.
> 
> Ok but I have to use a dummy trigger for every device?
> 
> Denis

No. Allocate your buffers and allocate your one trigger. Before you can
enable your buffer you need to assign the trigger to the buffer in sysfs (By
writing to trigger/current_trigger).

- Lars
