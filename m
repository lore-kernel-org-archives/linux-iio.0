Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022124.outbound.protection.outlook.com [52.101.126.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF419EED3;
	Mon, 23 Mar 2026 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229699; cv=fail; b=cxac/rNZsNGNW3L6EIIMtjDJoukKfQ5svn4q2/eqRk4emk7GNGgdSsPe+rH8XPTsdYy+tGSu6lrzdCeS3GR69vmNBXFmZt+V+mchpYhRza2A6UDwWUg/NAlWMybsd6TtgcNY9S+uxLJPRKSWAOPqlG9r4loapEmCVaA2L5wAgaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229699; c=relaxed/simple;
	bh=e5ecdGoCPhCoKh1q9En4DQCqYoKDP5QqpwTMtDHslOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Fo55Y0B7dlMquB+27NP90gVM4Vxm7S2DhLEIbaG4XrI6e+MyodfbIdI+TvN2tNS9A/y4Z/rRMSU7JUY1GZlk3SIh/Vbz81LmjVLYN6q573sDwVOi0SExoYznC4LbC0/vSJdb43JGM8Y0mhOGXJ26yjqNEGQydPWRLdCRDX4gBoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.126.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9pd8ti7QK7urG7kIpKyAI9KeB2OtDzYXnqhNZUaB1hTugq8V2wmpW2VdInVR6PQ230vIAmg8dM7h/bQxpT7rOq4d/+ULgay10chCPioPAfFSR7XZDZf2fqZkcKYhTJ+AuXMEWPdUHax4ltPhcuB0VCBe/G7wxjtPGDdzJzAmqd3URGEvkQl6ia0/hL2Zy77XyZI894IMRUKYbW1MwHEBNF+Rr+tOb1NhSeOWL/b38FkymQTIY6kbsCMuJPUr8Xfvl3HPxpvNM2rXSBq0gdZ+fNFU2ZL79e2d9JhPws5ue9YnQXHGSAgi1KUi3C7RpcS9ejtiT6L7/53UPnuoYSoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxA8awaYMuMi3hKwi3/LkaxQnkuy7rB9WKY4Ll0JtTA=;
 b=p4/fUGXv9uOn1BIXEd2A+8pExn1WIXRqe6W/KmKVuWZ48NsTBUTlQSmz7WUx4URyNMJR6HBpSoOf22g9LMG6EV4tl7cunzJ0oM2uPiXcAm3iTwbuzBGSXLffi5c+Rj3EQUygxn37DMcSsHsmmjVtxsUesKwSIfmBWxzbUKhuldItCp3zkc9y52IPw+8rSYPvfXmrc4E0DPhTsuOFj2v0JA1VjjE8nRkb+xBS0SbXL9KgjBakX1wfgTGFnVEqhGBaqLpogDbNuC6hUbEzTkgooB9Y868CGwpTVP3pZ+WYjhYGRXWWyAbDiqy7LzcOgOEuXanJMfHb5YcPHOxuWWTUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.30; Mon, 23 Mar
 2026 01:34:52 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:34:52 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v2 0/4] iio: adc: meson-saradc: add support for Meson S4
Date: Mon, 23 Mar 2026 09:34:04 +0800
Message-Id: <20260323013408.429701-1-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|KL1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: dfaf0386-6e12-41b8-adcd-08de887c6170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IEKlHGAhc9assZAwda1ov9EUlbWL6qfsXzgeKqwwru52kAXSOapuloHIW+MChanlAN76pOb81sMWZXc7tOSKXVc4yXishVsT/uUZ79HuDX4LiNPXwxWZcRiuCPm8KJLWeV4SrrMeFAH34YTVUDm2hVEOzZrO15/W+ux6DBhXDJ4AWKHOL9lhYj3tRMO0hhn5MYzpeie0tx+yE7f9tHpgjPVdfwzS58UsiaY74NMniXo1vAfRlVBolrvI+S1euchqfeAO8ykrhAK2b4LtnaSeK7jQI6XrM8UF/atAAClTu7qdAPXn5grXfSSpW+6el7buXZ7eIs53DMOEbRK4zPv2Feg5W7AdGPE3rmYO9lxiu47IdCkHbQiXAi+aAiYchedGeNSXartHvWHJBou0ePlJTYXAB0fSbPy9GT4sIZ8iUjwSy3cM1BFFwzzmXFZ+L/fhKAaG6dLl+NmSgJusCAM4ppgQqSKMSIUU/kwKmHxZCqDSmqQ0qA9w8mGdrAkqGh5pwEujo9UjdP8ELHCkX0aWEbwFsSEsui1k06MAtRWvqQjai3dEJubOdhRFHfaWcroXI0C3e/EmwJEQX16pdJ6B+9Az6DKFLg3XYlGobu/eDKMn+0dUs+PvMq+zelXC4+xulMM6LLYzjz5F7U60lEtZHNh1keURmHPoRRlZ2BD1cU0CI9CAuFK7HqrQ8Pe6LEfT9IdbZQedkj113d+0fuCo6gEWvAAy/2VfiEFP25K4yqI7h2sJ0XiW+yayA6l2ZE408l5i63Fxtc8e1yLVCDojmEeaVnSGPT5Y5X4z8SKcHW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbCGD42aeP7UDdN8P+XSR4/lpr5AJX6LVzIyZriGXNYme7V4t5n3eRrQrozQ?=
 =?us-ascii?Q?dQatKDSKFGFBucQlqpXAZII1+0jvQ3chakENHOAtrhxtpDHiptFBVKtN7t03?=
 =?us-ascii?Q?dHc14/JtxFUfYH9Wy18LI0I/BTrPnnATlBOJhAa0j1Adf5qxKRo9mxhqehgv?=
 =?us-ascii?Q?JsQsLvxS9geOUDdu4n/22chgGGRpnT79tZcVQIB2NtsxjZCj/1fX6CFRE206?=
 =?us-ascii?Q?DkiSRrLMTO8cWXeXAaest8nNxFJXxG/gmKYuUtLeNPnVqiKwl1mPZBkxH1VM?=
 =?us-ascii?Q?27VogBt13Yk/0bWHI4G/rXmjN2qATk3riRx2E09XyO15Jnrg6PuBsBaznyvN?=
 =?us-ascii?Q?VntOVMl7POD7fxzoHCdM+FzXbvn623Dmkg19LjMicPVLeET2Li1U+lLfFjda?=
 =?us-ascii?Q?F06dAa/R96jt9AwBtNJ3nCk3/4AEsNmZkHri2K30oIOvACQneGMEaMHs4w4S?=
 =?us-ascii?Q?lc/gJcbz/LLeZ0C4ACD3Cy/qgC5Wa+2KWlIyyh38RCDqEwOx13HmthTz9zqp?=
 =?us-ascii?Q?6LFWOP//+/Zuv7rmCDtdo+53Xew92eC+DG10AH//ViVMF5eQ+GkKshuAE6FK?=
 =?us-ascii?Q?bovbw1rKaMwd9j+ZW2uWqcl6AF8n7UEU727stQ1WPHgY8eIRuXjhbRkyuxNT?=
 =?us-ascii?Q?3SIFMKGKN/HalBlLtrqtjmyL9s5YTOtW+DLjxlLSlkr8RCki3/vEeDzljCzt?=
 =?us-ascii?Q?bj45BaJ3F0eQWKE0ZtRaUsxWVGkEGrtC6WxkyZv+DqL6iv5qNsyb6XTHwHfR?=
 =?us-ascii?Q?OWPEF/q6hgYc+xQUD8H1LuogxjGR510/XUUHIKIwue0UMnopo8zlOdil+vsM?=
 =?us-ascii?Q?HNr/v1d7TfKWKE4o5V/+5YTT/MdqxZpYJTLamnlzJ2RTyUtgMsZJZv/eFWyS?=
 =?us-ascii?Q?cigvNcExPdZMYraQpBHt1QST5E4FEkB3UZ5OXwVMmw1I60AJ9/ZwHGVLIvpD?=
 =?us-ascii?Q?IqRM6XHMgWh5uku/rOaZSj6BaLHHouJ9GRjSdohmcEr7FLU5kTcUDWHmELPy?=
 =?us-ascii?Q?YoYybXeOzK7yFIVfY+lFkwxe+iuY5PgH3mLCn6uG1dNHNbOFG0C4GUS1VSOn?=
 =?us-ascii?Q?T598baXLXyYpe6lmX6bvp0OX8fg/R9hguI3D9R8U99QJrYIyL76JDPU4pq7x?=
 =?us-ascii?Q?4jS6fjwAcldS+5MBMjuX4xt1YpT+8j51otTiQn7+MixZaKISBgUUTuIUdWa1?=
 =?us-ascii?Q?kjCqNnyQ4r1tgYigBL3zNtB6b8CGnZxjgS1OJI8QW0AGtR9bmA0ozNsp2bEp?=
 =?us-ascii?Q?yyuR3ycXTXgMqBXC8rwfBpUsTZFnQ1nyBj9/MCDLosjjtiAXioExeZNx9uPg?=
 =?us-ascii?Q?M3mTZ7wZGDkiFsSuFWtJlpjobLOW2tFPokHdNhWPJKlraJWaowthzZjtpJm5?=
 =?us-ascii?Q?yQ9nuqVBh+bDM0TVUDnNqxMFn8za31f2GBi0prDsziy0XcFqfrYVZalLA6V8?=
 =?us-ascii?Q?bbRqYIfqDsFPw6vD2DqZtNISRvHLRL7nJcvuvI7s/y8xk8lnc+TVSxvW8jza?=
 =?us-ascii?Q?zT6zPLdgs5dbIbLji5RALJS22XyFn87d4wwddU2xSrFLycRP6Z/wmLlOEEy9?=
 =?us-ascii?Q?2l52d4/jawTfRhQOuKWIhFErDPNj96PyrwmyvUB6UDrfYMh6T8mGxoIjgjxV?=
 =?us-ascii?Q?K5bvFf0U2/CLGAR0qjpsTFMgMlcwU6FHNhsnYAwdGqHsGwj6QVi0qUD3Ts6+?=
 =?us-ascii?Q?jjA45RVeVuCMfHpuYYz6gB28tGyUqLogZT8FKZpNwYAQF2Wj?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaf0386-6e12-41b8-adcd-08de887c6170
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:34:52.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aly5l8jMi0YVIhWbOb3L57RF+Tckh317JWzbsJGOOz+vKoTg+o3Keo3IXrZw2Pz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142

This series adds support for the SARADC IP block found in the Amlogic
Meson S4 (S905Y4) SoC and enables it for the Khadas VIM1S board.

Changes in v2:
- Addressed feedback from Krzysztof Kozlowski:
  - Updated dt-bindings commit message to explain the hardware compatibility.
  - Separated the S4 compatible string in the YAML bindings to ensure it
    correctly falls back to the specific "amlogic,meson-g12a-saradc" rather
    than the generic "amlogic,meson-saradc".
  - Updated the S4 SoC dtsi to use the correct G12A fallback.
- Added Martin's Reviewed-by tags where appropriate.
- Link to v1: https://lore.kernel.org/all/20260228065840.702651-1-nick@khadas.com/

Nick Xie (4):
  dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
  iio: adc: meson-saradc: add support for Meson S4
  arm64: dts: amlogic: meson-s4: add internal SARADC controller
  arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key
    support

 .../iio/adc/amlogic,meson-saradc.yaml         |  4 ++++
 .../amlogic/meson-s4-s905y4-khadas-vim1s.dts  | 19 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 14 ++++++++++++++
 drivers/iio/adc/meson_saradc.c                |  8 ++++++++
 4 files changed, 45 insertions(+)

-- 
2.34.1

