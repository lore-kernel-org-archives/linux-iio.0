Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpbg303.qq.com ([184.105.206.26]:45916 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdDBRtP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Apr 2017 13:49:15 -0400
Subject: Re: [PATCH] iio:meter:ade7759: Removing use of deprecated macros
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <51add231-117a-2fce-9ad8-d4d477707715@foxmail.com>
 <alpine.DEB.2.20.1703301020240.14237@vps.pmeerw.net>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
Message-ID: <38f92160-0ab0-1472-528b-023dc1edda8f@foxmail.com>
Date: Mon, 3 Apr 2017 01:41:46 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703301020240.14237@vps.pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017年03月30日 16:21, Peter Meerwald-Stadler wrote:
> nOn Thu, 30 Mar 2017, Chen Guanqiao wrote:
> 
>> Removing use of deprecated macros(S_IRUGO, SIWUGO, S_IXUGO), and replaced with 4 gidit octal.
> 
> digit

Thank you for replies with me, do I need to submit the [patch v2] again?

