Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-063.synserver.de ([212.40.185.63]:1054 "EHLO
	smtp-out-062.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752700AbbFRPOF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jun 2015 11:14:05 -0400
Message-ID: <5582E038.3090207@metafoo.de>
Date: Thu, 18 Jun 2015 17:14:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: JESD204B support
References: <CAM=Q2cucHAsMEYb-YtB2oU9d7wHk-KD+XVCMtuNMbaBqqn4+Cw@mail.gmail.com>
In-Reply-To: <CAM=Q2cucHAsMEYb-YtB2oU9d7wHk-KD+XVCMtuNMbaBqqn4+Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/18/2015 02:46 PM, Shubhrajyoti Datta wrote:
> Hi ,
>
> I was wondering if there is any plans or existing support for JESD204B.
> I was thinking of IIO. However any other ideas may be welcome.

Yes, IIO is the way to go. We have some out-of-tree drivers for JESD204B 
chips. They are not quite ready yet, but we'll get there.

- Lars

