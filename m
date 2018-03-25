Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34872 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeCYPMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Mar 2018 11:12:23 -0400
Received: by mail-wr0-f178.google.com with SMTP id 80so15353144wrb.2
        for <linux-iio@vger.kernel.org>; Sun, 25 Mar 2018 08:12:22 -0700 (PDT)
Received: from [192.168.1.103] ([197.52.163.206])
        by smtp.gmail.com with ESMTPSA id 104sm13047251wrl.26.2018.03.25.08.12.20
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 08:12:20 -0700 (PDT)
Subject: Re: Duplicate scan index 4!
From: Mahmoud Nagy <mnagy1312@gmail.com>
To: linux-iio@vger.kernel.org
References: <d4d848a1-45c7-90fb-52b8-ee64dbe3e710@gmail.com>
 <e1c03285-e107-5e83-2b22-1ed74e6fa0b5@gmail.com>
Message-ID: <014162fa-7f94-77cc-f2df-7955f0d4d42b@gmail.com>
Date: Sun, 25 Mar 2018 17:12:17 +0200
MIME-Version: 1.0
In-Reply-To: <e1c03285-e107-5e83-2b22-1ed74e6fa0b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The timestamp is given a hard coded index 4, that was the problem.


On 03/25/2018 04:13 PM, Mahmoud Nagy wrote:
> I don't know what actually use scan index 4, and I can't find that, so I
> added a dump element in index 4,
>
> and started with index 5, but that's a really bad solution..
>
>
> On 03/25/2018 04:06 PM, Mahmoud Nagy wrote:
>> Why do I get "Duplicate scan index 4" from dummy iio after adding a new
>> scan element for task 3 "DUMMY_INDEX_MAGNX"?
>>

