Return-Path: <SRS0=MckS=ZX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF40C432C0
	for <linux-iio@archiver.kernel.org>; Sun,  1 Dec 2019 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00092071F
	for <linux-iio@archiver.kernel.org>; Sun,  1 Dec 2019 12:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfLAM3Y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:29:24 -0500
Received: from www381.your-server.de ([78.46.137.84]:36676 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLAM3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Dec 2019 07:29:24 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1ibOLp-0000dB-Li; Sun, 01 Dec 2019 13:29:21 +0100
Received: from [93.104.96.105] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ibOLo-00093e-PF; Sun, 01 Dec 2019 13:29:21 +0100
Subject: Re: iio_compute_scan_bytes does not seem to account for alignment if
 first channel uses more storagebits than its successors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>,
        linux-iio@vger.kernel.org
References: <ff5a3ea4-4d15-5be3-9cb8-9fd7c716e2e6@plating.de>
 <fef18238-85cc-00e7-ee7d-a52c62509c22@metafoo.de>
 <20191201121029.6addd974@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <810ab64f-31bf-c4af-a655-7bddf364dae4@metafoo.de>
Date:   Sun, 1 Dec 2019 13:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191201121029.6addd974@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25650/Sun Dec  1 11:04:04 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/1/19 1:10 PM, Jonathan Cameron wrote:
>>
>> E.g. putting something like
>>
>>  unsigned int first_index = find_first_bit(mask, indio_dev->masklength);
>>  length = iio_storage_bytes_for_si(indio_dev, first_index);
>>  bytes = ALIGN(bytes, length);
>>
>> below the loop should do the trick I believe.
> It would work for Lars case, but I think a combination of both approaches
> is needed to handle cases like
> 
> u16
> u16 (may be padding)
> u32
> u16
> 
> We need to realign to the largest sized element whereever it occurs in the
> channels list.  So find that whilst computing the individual alignments,
> and apply it only once at the end.
> 

Ah, yes. We need the same rules as for the alignment or padding of a
struct, which mean align the size to size of the largest element.

