Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44111 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbaLZJjc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 04:39:32 -0500
Message-ID: <549D2CD3.80403@kernel.org>
Date: Fri, 26 Dec 2014 09:39:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 2/3] iio: frequency: Remove unnecessary braces around
 single statement block
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com> <1418721107-5429-3-git-send-email-roberta.dobrescu@gmail.com> <5492FD46.6000303@metafoo.de>
In-Reply-To: <5492FD46.6000303@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/12/14 16:13, Lars-Peter Clausen wrote:
> On 12/16/2014 10:11 AM, Roberta Dobrescu wrote:
>> This patch fixes the following checkpatch.pl warning:
>> WARNING: braces {} are not necessary for single statement blocks
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Applied to the togreg branch of iio.git - initially pushed out as testing
etc etc.
