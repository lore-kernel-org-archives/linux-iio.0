Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:40002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeHTQov (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 12:44:51 -0400
Date: Mon, 20 Aug 2018 14:28:56 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Martin Kelly <mkelly@xevo.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jean-Baptiste Maneyrol" <JManeyrol@invensense.com>
Subject: Re: IIO driver for the Invensense ICM-20948 IMU
Message-ID: <20180820142856.00003804@huawei.com>
In-Reply-To: <07126db2-bb47-2be8-b43e-42171d60ff57@xevo.com>
References: <07126db2-bb47-2be8-b43e-42171d60ff57@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 16 Aug 2018 14:36:32 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Hi,
> 
> Unless I missed something, I noticed the ICM-20948 IMU from Invensense 
> appears not to have an IIO driver yet. I'm wondering if there are plans 
> to add one and if so, the expected timeline for it.
> 
> Thanks,
> Martin

Hi Martin,

I'm not aware of anyone looking at this part.  A quick glance a the datasheet
suggested this has an entirely different address map to the existing parts, so
won't be trivial to support either.

Hopefully Jean-Baptiste will have more information for us!

Jonathan
