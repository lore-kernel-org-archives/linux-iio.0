Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D8CDB47E
	for <linux-iio@archiver.kernel.org>; Thu, 19 Oct 2023 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjJSCRW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Oct 2023 22:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJSCRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 22:17:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44F123
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 19:17:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F027C433C7;
        Thu, 19 Oct 2023 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697681838;
        bh=HNyaJK1axkB8a7ESL1pozO2YJsPnMyYS2HYz0QpJPBM=;
        h=Date:From:To:Cc:Subject:From;
        b=tZhSOuuhqLGi8uy8RXT9IOlF6Ze9IlHoMSbr4b6M6/3RDWF8wtqtB+vmVtYrLFdwo
         w7hPYjwDkSveBb5Trvm4Zl1lPR4siJBwVWhgZ92vPZvAf/FJZtnVVjMDpAm1sa/Oqb
         w7SDKx70pIl++Pl1rfykYbXhcKKzty/y9rlfznTA9Dj+JHM20O4xlDqGz1XQsVnpPb
         ba50o3NlO+h03arD/WSEOA0vwo2bFUFNtmD1Ora0Li67JvtLRM8rj7ibAjtkIx9f2t
         V3zNlQHue/Mip1naz9ciGBvJl0qy6hEbl/pmuQgd8UzHpLmGPx41qzCvbXY8vLSMgq
         X8uglZ9ncfv/A==
Date:   Wed, 18 Oct 2023 22:17:15 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [GIT PULL] First set of Counter updates for 6.7
Message-ID: <ZTCRq/9L64kTqiyz@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mtW7wjFwRTHXkVQo"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mtW7wjFwRTHXkVQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.7a

for you to fetch changes up to 7904cdf1397c9391178ce53a7ebfa099c6bc4a59:

  counter: chrdev: remove a typo in header file comment (2023-10-16 11:38:56 -0400)

----------------------------------------------------------------
First set of Counter updates for the 6.7 cycle

A minor typographical error is fixed in the description comment block
for struct counter_component.

----------------------------------------------------------------
Fabrice Gasnier (1):
      counter: chrdev: remove a typo in header file comment

 include/uapi/linux/counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--mtW7wjFwRTHXkVQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZTCRqwAKCRC1SFbKvhIj
K2sCAQDzQFxUQSQDjCFCaMAeGY9xi6EZbCBxon00PiI3UGav/QEArqnZiY6Tf68i
Vq7dLDEi63wcetQ9NFtXlFD9Zc/oBgk=
=YU9W
-----END PGP SIGNATURE-----

--mtW7wjFwRTHXkVQo--
