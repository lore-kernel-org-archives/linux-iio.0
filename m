Return-Path: <SRS0=OALH=VL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F0C73C66
	for <linux-iio@archiver.kernel.org>; Sun, 14 Jul 2019 16:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF87214C6
	for <linux-iio@archiver.kernel.org>; Sun, 14 Jul 2019 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563121704;
	bh=Axt8sU7UfJ4j3rkf4SzhJPvWZjsC3ZZwTgXi7cfhbiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fc1pH7Wi37lo/isVywUwMNIXI70qnftspOa4w9FeGNbTx8LxT4BsGSfpNQ5goAWpT
	 Q9eWr5cqkPTq3/eGiksoBiSUvvaVoQU8MeON4VboNb18WnfcdzM7/vj8KEf7X7b9G3
	 XFqnAT9bdP9a0JVTDBcbOzJ2rxsiOEVRanwB8io0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfGNQ2X (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfGNQ2X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:28:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960A02089C;
        Sun, 14 Jul 2019 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563121702;
        bh=Axt8sU7UfJ4j3rkf4SzhJPvWZjsC3ZZwTgXi7cfhbiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L1M+ZKOxSLjWg/2oa4p5ee3CdGoZxLgnIYKTAIzm18cGG9q4mrd2gsunnVJmul/NX
         t9NcUqXtaopc5iN+Jai3VwmiQd+AzE1pMT+HBh7cN4enpPK4pbWkmDGnoC6PWWg3KJ
         oTBPLhO1geQHzjwCw+kBGSed4seZ27muIlwLTksM=
Date:   Sun, 14 Jul 2019 17:28:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds3tr-c
 device bindings
Message-ID: <20190714172815.4f24eac8@archlinux>
In-Reply-To: <89edf867d6abb738527889040f030036173fd5b8.1561802767.git.lorenzo@kernel.org>
References: <cover.1561802767.git.lorenzo@kernel.org>
        <89edf867d6abb738527889040f030036173fd5b8.1561802767.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Jun 2019 12:13:54 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
applied.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index efec9ece034a..92b48f242356 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -11,6 +11,7 @@ Required properties:
>    "st,asm330lhh"
>    "st,lsm6dsox"
>    "st,lsm6dsr"
> +  "st,lsm6ds3tr-c"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

