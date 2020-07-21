Return-Path: <SRS0=ZQOz=BA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C1C433E1
	for <linux-iio@archiver.kernel.org>; Tue, 21 Jul 2020 12:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEEC22482
	for <linux-iio@archiver.kernel.org>; Tue, 21 Jul 2020 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595333968;
	bh=f47xYJVDLjuHwsEsuV6hymuSt9wQDZBA5/k8Bfez7h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SEWxvZrO3HVxiZTPFSprSaruox0a2sJpWwKVc4+cObaUOCcJLLUBSbOLLg3/pVBeX
	 bjMzvPQIFnv2oxB/VbHsupiDqEc/BCAKnwYvQohzMRl0hEEnyYbrAL7HSoP7osJUtg
	 kuuz083MV1hVQA/veKn2sJvAlDK4e/810Gtv0X+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGUMT2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGUMT1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 08:19:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D15221702;
        Tue, 21 Jul 2020 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595333967;
        bh=f47xYJVDLjuHwsEsuV6hymuSt9wQDZBA5/k8Bfez7h4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VRsBW+Qb8OEazZU4kNCmVnUBHpsee+fj7yzI5ateGNItk3nQLnfRKx3gBE4Zw/FNF
         qk8muiFtMQSicKhQHO0fYvSMmWN/fK+egz1l8Y0SczmRUjBKlVSnhd3NivSHOdw37b
         IuTNm0sHcYlH6bbsn2tVZl7Vaex5UWuY1UOr7qas=
Date:   Tue, 21 Jul 2020 13:19:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: core: fix/re-introduce back parent assignment
Message-ID: <20200721131923.4885d87f@archlinux>
In-Reply-To: <CALT56yO842Kt56Dtsd-+YE04-HbH7cQnEQpn6dp+7YhYJ=-hYQ@mail.gmail.com>
References: <20200721102407.134402-1-alexandru.ardelean@analog.com>
        <CALT56yO842Kt56Dtsd-+YE04-HbH7cQnEQpn6dp+7YhYJ=-hYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 13:34:19 +0300
Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:

> =D0=B2=D1=82, 21 =D0=B8=D1=8E=D0=BB. 2020 =D0=B3. =D0=B2 13:24, Alexandru=
 Ardelean <alexandru.ardelean@analog.com>:
>  [...] =20
>=20
> Tested-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>=20
Applied to the togreg branch of iio.git and pushed out as testing.
Current plan is to do a pull request tomorrow so should make it in time
for the merge window.  If it gets delayed for some reason we can send
it as a fix after the merge window.

Thanks,

Jonathan


