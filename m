Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF252369216
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634532; cv=none; b=d02FTff/AfatH3u4EpQgE8kDj1/MxZPdH7FB56PTQf1zUhCV/vuP1SRRUS2cpo8Fn3LSqAVWRiWcOh6qUG3ZoyZl9EdhHeXuTZUytgJ8v/9WZIgjzrQYb+1dCZgY8c9906cgM1cQeaVOZmpowktM7h4dtMpFEYd/vwJBD+oXQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634532; c=relaxed/simple;
	bh=2FWZb65X8mx18YH9h8vMRViW9qAP67jaLh6l/pLRM98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K3qCvNeXBgHk7I0qlUXNQt8hpVkZikO5kUFR+rlGjCNy6f+5s3uIJOxZ4OXK9Y5yHc73LG0CSeNdqUprfKDR574tCJy+/vtbMasx5l/MRHbo6dQutw7gR5NygDwSQPar8KS5fJvT2wM7/Zw0BKdSzFsbkV5MvpG13WiP3qP1des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V2f8s4QP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1XeHXK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V2f8s4QP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1XeHXK+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61959lZT1923235
	for <linux-iio@vger.kernel.org>; Mon, 9 Feb 2026 10:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WK0ylVF4GwQX20f4H+s8CJYlFpp8VJaq11P
	Zdrcjft8=; b=V2f8s4QPfNIBmLm6u/ozo1qJQcDmFYmrPYaI7FjJMG3pwNtVhQp
	eaHn+tJP/tgGa9LTiu1oFbmTz2CgrFlJVH1DPBq0ZcU6QcythTYBPswHLMUrvBXF
	teJM7h48kpU5MDXmOcXeqIAcVhI5lb89Bx+xulfzLvG4Z99VMGtDGe6T2+zAFcax
	Q8o6fF8HTRXV7k0F2M1Kq52YsQ5xAI86QVVYLsciK+Su67778gyl5PKn6Cc8ZlNI
	hfoIAdy9NcD1R37UODQhiknNOGqtQDVO6CfW2YlKXuVEbCtN9DetF+zunjcyS55R
	ESCzTcDfRtWSPiIbmaVL+VwtBb/8VorrPIA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c796ks597-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 10:55:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6dded42ec4so1340201a12.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770634529; x=1771239329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WK0ylVF4GwQX20f4H+s8CJYlFpp8VJaq11PZdrcjft8=;
        b=I1XeHXK+DHs2tapF5lAow35wDhSKqOGe4SjHt6+DxpCX5DXI5qdAwIEyKuqYqbbo07
         wP/k+F7i3Pr6IZYecG1Anv7qvgcAOSX6Y8OVqJzWojUCT3gt01lHUZ8lw3IoWCI2jBkc
         /vvn2TzkdHxE+3lcDKZ9o3D4Qj5Zm4GlH8Qrxgx/RM23tVDez03Z8T5VbQD4RGXC6IYu
         hhsqjrYpOssTd3RJl0tdEZMCvhasXPCtNowiTs3VXdAenRIBx90nT20LhJCDo+9SvNey
         Z559G1EPVe5QAmHYJNn0DmU5BtpPIaGVFpg7mBmC9kgKTynXONRIb4Kk1F02pafDBOPC
         cVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770634529; x=1771239329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK0ylVF4GwQX20f4H+s8CJYlFpp8VJaq11PZdrcjft8=;
        b=rizzyqxNhkieP+/pBeuTl5zm39rQkMRP1gxAxQpC1cBqhEXUVGjLt9UmQ7WYGY1IRV
         5yDCAM3E5UgTVmLP5r18giiKz4oyBZSjyd+9he2RkEl2lKg1iLjiTab13T0Cq0Tg1P66
         yiWX0EDRikV6+/SltyQLec41cDTlwSUv2f0xXcsygXcpR34N7IKGoo6gcglGl8IBxP7K
         Utq61ho75Vcig4Xa7BAZrzzultGfE1Iu+WVtSzZzGccD8AKN4g5YMaUJ3qrAwaZyk3QE
         oKsOw3iMELUJXJw6OpouEzoIsENyTq7i9duzDZwyqMqX35RJ6HZNASWC2XTSG4jaAbRh
         fGvA==
X-Forwarded-Encrypted: i=1; AJvYcCXUfk+6P3CAG32mkyRy798xlamBe3/wmfWQHnuch2azfk1gz3g/V+nA1dU+v7gkFMlPKO8hk4FAfbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38UIvObpCHH8xgOKn9uQTZ/nMuRzU31GPflZ+2se9emZuSniy
	rDJEkH0rgBSD5XP+bZhcum8RMT7FwbDOln6Tm3ZX83wTLXF8Lsz8nrzzRsi+UBlhWeBjq1EBInS
	Vb6SfsbfI3ro/YH0sTyrcZ4N/vIf1kdS/bn6KYBTcRILZaN3qECLdhEi6jfqsj9U=
X-Gm-Gg: AZuq6aJfI7KUh8jB/AGkyFxu2sTCmNKrdVpylb7RsWDAb+rHRWym4zXeqFksuJz21zC
	Ctd44iva+ONwsE1LZ0Ut2jKw0720ZM1Th6sIX8PpRvLgcyr/UlmdTBPIWitejkVNDnN+DwUZT/A
	9EyeUmluKA/kLlU8G7zDAxMbtsSLzjnCA/2rKHU+i6snIFGDcU4jnyUqU+SGrXX8ru0cQBl/AQA
	Ba5yuWO9edDtUe3wu2w5+eRSXfPpGR+WQlOonMmHu0Hqof4SfaRYNxa7G1I/dTeaq8P9lr47SGJ
	MsQG+KQZunL879D+vulgPibUxLnEt5L+ZzuFuyo6d/fXlku5eLwhc/WRy7B+ztZtzGROS48VqDf
	tG17pBUUaDRQr1qUsxXSqeN9ordxR4q+ilYYndV4AoaOq
X-Received: by 2002:a05:6a20:d524:b0:2bf:183c:ac86 with SMTP id adf61e73a8af0-393ad00062amr10309844637.25.1770634529443;
        Mon, 09 Feb 2026 02:55:29 -0800 (PST)
X-Received: by 2002:a05:6a20:d524:b0:2bf:183c:ac86 with SMTP id adf61e73a8af0-393ad00062amr10309818637.25.1770634528866;
        Mon, 09 Feb 2026 02:55:28 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e5f6bsm8358837a12.20.2026.02.09.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:55:28 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
Subject: [PATCH V11 0/4] Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Mon,  9 Feb 2026 16:24:34 +0530
Message-Id: <20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IeyKmGqa c=1 sm=1 tr=0 ts=6989bd22 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=XccleKrqIk_kMzO7r2MA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dS1Zw4ILXtE-OGGqOLpTHmns5PKVNxR_
X-Proofpoint-GUID: dS1Zw4ILXtE-OGGqOLpTHmns5PKVNxR_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4OSBTYWx0ZWRfX9tHQ/jCEqUj8
 Qpc6zNNXJ15bu09oepBTyAe47f/VHjbt3VJtlnD/SCs8dOUAXX1Xm7KVAHttSNT0yZm5C31aiBB
 nOiFaDpjtcvXm2/7zcFrtXj+U6Tm+6c7s37Eee45pTP/WlqKhnhRIFgMUknwlD/PTU/BmkbHBdZ
 Ak5xSUqgss/KxcL5EvJk/uukrBGMFmkB0IDPS6TEXi/RXhr0smI/SFiTf3GgoREaqyKOt2nSeUT
 e3q4COl2d1IaNjqAm4+Z7twRGSHCx94e2YOYv4DPGZfNj5vXGHnf3Q8JjpGirQcSM4d+LuiHb3/
 5syzSAInX3F2UDHbQ3TTq/aMdeGV3BCbx+a6q8SEhMQ5ll1Nv7/QJbMMLdwr6joQeHlsR26LP5I
 1hbeKG0It0YOeVopBSMEd2WdZJJ0HmxICV57jTpruSZgqLkX64ngJ4UHDXvkdXzvTPO+6/D0+ik
 2A96twLVRkPZyRRBsVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090089

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same module.

Patch 1 splits out the common ADC channel properties used on older
VADC devices, which would also be reused on ADC5 Gen3, into a common 
binding file, to be referenced in Gen3 and other ADC binding files.

Patch 2 adds bindings for ADC5 Gen3 peripheral.

Patch 3 adds the main driver for ADC5 Gen3.

Patch 4 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Changes since v10:
- Replaced inclusion of device.h header file with forwards declaration of
  struct device in two files and updated all for() loops to declare and
  initialize the loop iterator in for() statement as suggested by Jonathan.
- Addressed some more comments from Jonathan for some minor style changes.
- More details about all changes are present in per-patch change logs.
- Link to v10: https://lore.kernel.org/all/20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com/

Changes since v9:
- In patch 4, replaced the break statement within scoped_guard() in tm_handler_work()
  with return statement to fix the error reported by kernel test robot.
- Link to v9: https://lore.kernel.org/all/20260128112420.695518-1-jishnu.prakash@oss.qualcomm.com/

Changes since v8:
- Collected Reviewed-by tag from Krzysztof on patch 2.
- Dropped the common module (drivers/iio/adc/qcom-adc5-gen3-common.c) as suggested
  by Dmitry.
- Made changes in patches 3 and 4 to simplify auxiliary device structure to use
  module_auxiliary_driver() as requested by Dmitry.
- Updated header files included in all newly added files to follow IWYU
  (include-what-you-use) principles as requested by Jonathan.
- Addressed all remaining comments from Jonathan in patches 3 and 4, for
  refactoring some code.
- More details about all changes are present in per-patch change logs.
- Link to v8: https://lore.kernel.org/all/20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com/

Changes since v7:
- Based on a discussion with Krzysztof concluded here: 
  https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
  patch 1 in the previous series is updated to move ADC header files from binding to
  devicetree folders, as they contain HW constants, not exactly bindings.
  Earlier in series v7, patches 3 (Gen3 binding) and 4 (driver) were dependent on
  patch 1, as it updated the location of include/dt-bindings/iio/qcom,spmi-vadc.h,
  which was used in patches 3 and 4 for Gen3 channel macros. In v8, these macros
  will be added in other new files, so the former patch 1 will now be a standalone
  change separate from this series, as the other patches here are no longer
  dependent on it.
- Patches 2/3/4/5 of v7 are now patches 1/2/3/4 in v8. Below comments refer to
  v7 patch numbers.
- Updated description of `reg` property in patch 2 to completely drop mentions of binding
  file paths, to simplify it and avoid any dependencies with patch 1.
- Dropped all ADC channel macro definitions from patch 3, updated binding example
  correspondingly and fixed formatting inconsistancies in property names, to address
  Krzysztof's comments.
- Addressed all comments from Jonathan in driver patches 4 and 5, for fixing formatting
  and refactoring some code.
- In patch 4, added ADC5 Gen3 channel macros in qcom-adc5-gen3-common.h, for use in main
  driver file. Also added a check to fail probe in case ADC channel value obtained
  from devicetree is not among list of supported channels.
- More details about all changes are present in per-patch change logs.
- Link to v7: https://lore.kernel.org/all/20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com/

Changes since v6:
- Collected Acked-by tags from Jonathan on patches 1, 2 and 3.
- Addressed Neil's comment in patch 3.
- Updated copyright to yearless one in newly added files, following new internal guidelines.
- Addressed all comments from Jonathan on patches 4 and 5 (most importantly for updating
  auxiliary device cleanup handling to fix memory freeing issues).
- More details about all changes are present in per-patch change logs.
- Link to v6: https://lore.kernel.org/all/20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com/

Changes since v5:
- Collected Reviewed-by tag from Krzysztof on patch 2.
- Addressed all comments from Krzysztof and Jonathan on patch 3.
- Addressed all comments from Jonathan on patches 4 and 5.
- More details about all changes are present in per-patch change logs.
- Link to v5: https://lore.kernel.org/all/20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com/

Changes since v4:
- Split common ADC channel properties out into a separate file to use as 
  ref for ADC5 Gen3 and moved ADC5 Gen3 documentation into a separate
  file as suggested by reviewers.
- Addressed few reviewer comments in driver patches.
- Link to v4: https://lore.kernel.org/all/20241030185854.4015348-1-quic_jprakash@quicinc.com/

Changes since v3:
- Updated files affected by adc file path change in /arch/arm folder,
  which were missed earlier.
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and addressed reviewer comments for all bindings.
- Addressed review comments in driver patch. Split out TM functionality into
  auxiliary driver in separate patch and added required changes in main driver, as
  suggested by Dmitry.
- Link to v3: https://lore.kernel.org/all/20231231171237.3322376-1-quic_jprakash@quicinc.com/

Changes since v2:
- Reordered patches to keep cleanup change for ADC files first.
- Moved ADC5 Gen3 documentation into a separate file

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (4):
  dt-bindings: iio: adc: Split out QCOM VADC channel properties
  dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 151 +++
 .../iio/adc/qcom,spmi-vadc-common.yaml        |  84 ++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  78 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 drivers/iio/adc/Kconfig                       |  26 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 860 ++++++++++++++++++
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 507 +++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 212 +++++
 11 files changed, 1856 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h


base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
-- 
2.25.1

