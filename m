Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58255 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdDCTxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 15:53:25 -0400
Subject: Re: [PATCH] iio:meter:ade7759: Removing use of deprecated macros
To: Chen Guanqiao <chen.chenchacha@foxmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <51add231-117a-2fce-9ad8-d4d477707715@foxmail.com>
 <alpine.DEB.2.20.1703301020240.14237@vps.pmeerw.net>
 <38f92160-0ab0-1472-528b-023dc1edda8f@foxmail.com>
Cc: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e3ee4905-45c0-da60-3f71-48b2665fa99a@kernel.org>
Date: Mon, 3 Apr 2017 20:53:22 +0100
MIME-Version: 1.0
In-Reply-To: <38f92160-0ab0-1472-528b-023dc1edda8f@foxmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/17 18:41, Chen Guanqiao wrote:
> On 2017年03月30日 16:21, Peter Meerwald-Stadler wrote:
>> nOn Thu, 30 Mar 2017, Chen Guanqiao wrote:
>>
>>> Removing use of deprecated macros(S_IRUGO, SIWUGO, S_IXUGO), and replaced with 4 gidit octal.
>>
>> digit
> 
> Thank you for replies with me, do I need to submit the [patch v2] again?
> 
Please do.  Also could you mention what sort of macros in the title? 
Makes it easier to scan a list of patches and think - oh another one of
those!

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

