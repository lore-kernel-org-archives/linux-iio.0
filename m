Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82207C433DB
	for <linux-iio@archiver.kernel.org>; Fri, 19 Mar 2021 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD8E64F6B
	for <linux-iio@archiver.kernel.org>; Fri, 19 Mar 2021 12:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCSMSB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCSMR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 08:17:57 -0400
Received: from [192.168.1.155] ([95.114.29.199]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7xml-1ljzsG0WYt-0152RE; Fri, 19 Mar 2021 13:17:55 +0100
Subject: Re: IIO advise + help
To:     Michel Arruat <michel.arruat@cern.ch>, linux-iio@vger.kernel.org
References: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d1acb346-7a01-3221-ca7f-40e993bed0e1@metux.net>
Date:   Fri, 19 Mar 2021 13:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mfXteQ781Dy2Tfqrhs7bZy35lt8HDC8tNVzEV22QcsvMBof77gR
 j9iQZXIyaAFEiDR1G3M6/5bx9ZISzkKIUUUNIzr8XwcPoeCch8SEqxulfKSLlful+ev4dGC
 TFMvSg2AfG7d3VBVxTnhzpA31bxhdnEa1Nnnnks9nDBFeioGdVYT7utk1Hm18xyLgUSCkuJ
 2syaLN8CcmcFL1PiKO5yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ti96QML9hxc=:BEVw+hhjcmIhzqUMjHNTs4
 7rkJXcmsMTVs13OWOnpRB6pNdmzxYNDgx91w8ITfwK8jZlE+rm2dCZblZwlNoAP6LvvstlQqJ
 PkUBZ2NnqZerliS7v1v9UbaA5XjscChrbhE5eRdXWgC5LNKszFONHFUxYPFF0VYSIG+bw1Bss
 CczthdOGc4rVyrH+KfnvL/UcXntx9ALOMf1ZQehm1p1B+YhGGeZ/29ubLsKDroaGLLOWMiBzG
 dHjDJfdVTvCblrxAi/yLv6cjhX0KkW6grLuwy3QUIMnrLPikZL2dIvIIwLNCWON7VRAsByJCk
 qFeKXEDTnvC/t2iGnvf99dI8SKR1m2/Kmfm+PIJbBD+U4Nr2jLdjPUfVl9btVDuU6bjCrvEAZ
 Dtyps14o04b7Yx0bxMw7eTWUzRxw40WDldrz3so9bbiycS9N4m+d4Widvkw65
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12.03.21 17:54, Michel Arruat wrote:

Hi,

> Could you please let me know which minimal kernel version is required to 
> use the "IIO DMA engine buffer" features.

for kernel development, I'd always start with master and frequently
rebase :p



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
